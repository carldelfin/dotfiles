---
categories:
- tech
date: "2021-06-27 09:00:00"
keywords:
- markdown
- code block
tags:
- test
title: Code Block Test
---

<kbd>CTRL</kbd>

`if xinput list | grep -q "floating"; then`

Fenced code block:

```bash {hl_lines=[1,"3-4"]}
#!/bin/sh

if xinput list | grep -q "floating"; then
    xinput reattach "AT Translated Set 2 keyboard" 3
else
    xinput float "AT Translated Set 2 keyboard"
fi
```

Without line number

{{< highlight bash "linenos=false" >}}
(() => {

  function createCopyButton(codeNode) {
    const copyBtn = document.createElement('button')
    copyBtn.className = 'code-copy-btn'
    copyBtn.type = 'button'
    copyBtn.innerText = 'copy'
    copyBtn.parentElement = codeNode.parentElement

    let resetTimer
    copyBtn.addEventListener('click', () => {
      navigator.clipboard.writeText(codeNode.innerText).then(() => {
        copyBtn.innerText = 'copied!'
      }).then(() => {
        clearTimeout(resetTimer)
        resetTimer = setTimeout(() => {
          copyBtn.innerText = 'copy'
        }, 1000)
      })
    })

    return copyBtn
  }

  document.querySelectorAll('pre > code').forEach((codeNode) => {
    const copyBtn = createCopyButton(codeNode);
    codeNode.parentNode.insertBefore(copyBtn, codeNode)
  })

})()
{{< / highlight >}}
