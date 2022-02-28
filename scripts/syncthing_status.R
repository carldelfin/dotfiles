required_packages <- c("httr", "XML", "magrittr", "dplyr", "stringr")
missing_packages <- setdiff(required_packages, rownames(installed.packages()))  

if (!length(missing_packages) == 0) {
  stop("Aborting due to missing package(s): ", paste0(missing_packages, sep = " "))
}

# define magrittr pipe to avoid loading library
`%>%` <- magrittr::`%>%`

# get API key from syncthing config
api_key <- XML::xmlToList(XML::xmlParse("~/.config/syncthing/config.xml"))$gui$apikey

# make sure httr doesn't complain about using self-hosted SSL cert
httr::set_config(httr::config(ssl_verifypeer = 0L, ssl_verifyhost = 0L))

# get information about possible/active connections 
get_connections <- function() {
    # try to connect via REST API
    res <- tryCatch({
        httr::GET(url = "https://localhost:8384/rest/system/connections",
                  httr::add_headers(`X-API-Key` = api_key))
    },

    # if there's an error, we are not connected or something is wrong
    error = function(e) {
        return(0)
    })
}

res <- get_connections()

if (length(res) <= 1) {
    cat("%{F#ebcb8b}")
    cat("")
    cat("%{F-}")
} else {
    # parse relevant part of JSON output
    res_parsed <- httr::content(res, as = "parsed")$connections

    # combine into df
    out <- data.frame(id = names(res_parsed),
                      connected = as.integer(lapply(res_parsed, "[[", 4)))

    # replace full ID with name
    id_part <- c(".*7LI.*", ".*HZ4.*", ".*6YB.*", ".*UQQ.*")
    name <- c("wintermute", "aleph", "neuromancer", "galaxy")
    out$id <- stringr::str_replace_all(out$id, setNames(name, id_part))

    # remove host from output 
    out <- out %>% dplyr::filter(!id == Sys.info()["nodename"])

    # how many connections to we have?
    if (sum(out$connected) == 0) {
        cat("%{F#ebcb8b}")
        cat(paste0(" ", sum(out$connected), "/", nrow(out))) 
        cat("%{F-}")
    } else {
        cat(paste0(" ", sum(out$connected), "/", nrow(out))) 
    }
}
