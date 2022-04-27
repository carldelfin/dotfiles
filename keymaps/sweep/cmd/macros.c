enum custom_keycodes {
    SM_TILD = SAFE_RANGE,
    SM_HAT,
    SM_GRV,
    SM_ACT,
    FN_CPY,
    FN_PST,
    FN_SCPY,
    FN_SPST,
    R_INST,
    R_GHI,
    R_LIB,
    R_FUN,
    R_DF,
    R_TRUE,
    R_FALSE,
    R_FIL,
    R_MUT,
    R_SEL,
    R_GGP,
    R_HERE,
    VIM_WA,
    VIM_QA,
    VIM_BD,
    VIM_VS,
    VIM_HS,
    VIM_CD,
    VIM_CU,
    KT_RNM,
    KT_CT,
    KT_PRV,
    KT_NXT,
    KT_NT,
    FF_ADR,
    FF_CT,
    FF_PRV,
    FF_NXT,
    FF_NT
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
    case SM_TILD:
        if (record->event.pressed) {
            SEND_STRING(SS_RALT(SS_TAP(X_RBRC) SS_TAP(X_RBRC)));
        } else {
        }
        break;
    case SM_HAT:
        if (record->event.pressed) {
            SEND_STRING(SS_LSFT(SS_TAP(X_RBRC) SS_TAP(X_RBRC)));
        } else {
        }
        break;
    case SM_GRV:
        if (record->event.pressed) {
            SEND_STRING(SS_LSFT(SS_TAP(X_EQL) SS_TAP(X_EQL)));
        } else {
        }
        break;
    case SM_ACT:
        if (record->event.pressed) {
            SEND_STRING(SS_TAP(X_EQL) SS_TAP(X_EQL));
        } else {
        }
        break;
    case FN_CPY:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_TAP(X_C)));
        } else {
        }
        break;
    case FN_SCPY:
        if (record->event.pressed) {
            SEND_STRING(SS_LSFT(SS_LCTL(SS_TAP(X_C))));
        } else {
        }
        break;
    case FN_PST:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_TAP(X_V)));
        } else {
        }
        break;
    case FN_SPST:
        if (record->event.pressed) {
            SEND_STRING(SS_LSFT(SS_LCTL(SS_TAP(X_V))));
        } else {
        }
        break;
    case R_INST:
        if (record->event.pressed) {
            SEND_STRING("install.packages" SS_LSFT(SS_TAP(X_8)) SS_LSFT(SS_TAP(X_2)) SS_LSFT(SS_TAP(X_2)) SS_LSFT(SS_TAP(X_9)) SS_TAP(X_LEFT) SS_TAP(X_LEFT));
        } else {
        }
        break;
    case R_GHI:
        if (record->event.pressed) {
            SEND_STRING("devtools" SS_LSFT(SS_TAP(X_DOT)) SS_LSFT(SS_TAP(X_DOT)) "install" SS_LSFT(SS_TAP(X_SLSH)) "github" SS_LSFT(SS_TAP(X_8)) SS_LSFT(SS_TAP(X_2)) SS_LSFT(SS_TAP(X_2)) SS_LSFT(SS_TAP(X_9)) SS_TAP(X_LEFT) SS_TAP(X_LEFT));
        } else {
        }
        break;
    case R_LIB:
        if (record->event.pressed) {
            SEND_STRING("library" SS_LSFT(SS_TAP(X_8)) SS_LSFT(SS_TAP(X_9)) SS_TAP(X_LEFT));
        } else {
        }
        break;
    case R_FUN:
        if (record->event.pressed) {
            SEND_STRING(SS_TAP(X_NUBS) SS_TAP(X_SLSH) "function" SS_LSFT(SS_TAP(X_8)) SS_LSFT(SS_TAP(X_9)) SS_TAP(X_LEFT));
        } else {
        }
        break;
    case R_DF:
        if (record->event.pressed) {
            SEND_STRING("data.frame" SS_LSFT(SS_TAP(X_8)) SS_LSFT(SS_TAP(X_9)) SS_TAP(X_LEFT));
        } else {
        }
        break;
    case R_TRUE:
        if (record->event.pressed) {
            SEND_STRING("TRUE");
        } else {
        }
        break;
    case R_FALSE:
        if (record->event.pressed) {
            SEND_STRING("FALSE");
        } else {
        }
        break;
    case R_FIL:
        if (record->event.pressed) {
            SEND_STRING("filter" SS_LSFT(SS_TAP(X_8)) SS_LSFT(SS_TAP(X_9)) SS_TAP(X_LEFT));
        } else {
        }
        break;
    case R_MUT:
        if (record->event.pressed) {
            SEND_STRING("mutate" SS_LSFT(SS_TAP(X_8)) SS_LSFT(SS_TAP(X_9)) SS_TAP(X_LEFT));
        } else {
        }
        break;
    case R_SEL:
        if (record->event.pressed) {
            SEND_STRING("select" SS_LSFT(SS_TAP(X_8)) SS_LSFT(SS_TAP(X_9)) SS_TAP(X_LEFT));
        } else {
        }
        break;
    case R_GGP:
        if (record->event.pressed) {
            SEND_STRING("ggplot" SS_LSFT(SS_TAP(X_8)) SS_LSFT(SS_TAP(X_9)) SS_TAP(X_LEFT));
        } else {
        }
        break;
    case R_HERE:
        if (record->event.pressed) {
            SEND_STRING("here" SS_LSFT(SS_TAP(X_8)));
        } else {
        }
        break;
    case VIM_WA:
        if (record->event.pressed) {
            SEND_STRING(SS_TAP(X_ESCAPE) SS_LSFT(SS_TAP(X_DOT)) "wa" SS_TAP(X_ENTER));
        } else {
        }
        break;
    case VIM_QA:
        if (record->event.pressed) {
            SEND_STRING(SS_TAP(X_ESCAPE) SS_LSFT(SS_TAP(X_DOT)) "qa" SS_TAP(X_ENTER));
        } else {
        }
        break;
    case VIM_BD:
        if (record->event.pressed) {
            SEND_STRING(SS_TAP(X_ESCAPE) SS_LSFT(SS_TAP(X_DOT)) "Bdelete" SS_TAP(X_ENTER));
        } else {
        }
        break;
    case VIM_VS:
        if (record->event.pressed) {
            SEND_STRING(SS_TAP(X_ESCAPE) SS_LSFT(SS_TAP(X_DOT)) "vs" SS_TAP(X_ENTER));
        } else {
        }
        break;
    case VIM_HS:
        if (record->event.pressed) {
            SEND_STRING(SS_TAP(X_ESCAPE) SS_LSFT(SS_TAP(X_DOT)) "split" SS_TAP(X_ENTER));
        } else {
        }
        break;
    case VIM_CD:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_TAP(X_D)));
        } else {
        }
        break;
    case VIM_CU:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_TAP(X_U)));
        } else {
        }
        break;
    case KT_NXT:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_LSFT(SS_TAP(X_RIGHT))));
        } else {
        }
        break;
    case KT_PRV:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_LSFT(SS_TAP(X_LEFT))));
        } else {
        }
        break;
    case KT_CT:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_LSFT(SS_TAP(X_Q))));
        } else {
        }
        break;
    case KT_NT:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_LSFT(SS_TAP(X_T))));
        } else {
        }
        break;
    case KT_RNM:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_LSFT(SS_LALT(SS_TAP(X_T)))));
        } else {
        }
        break;
    case FF_NXT:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_TAP(X_PGDN)));
        } else {
        }
        break;
    case FF_PRV:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_TAP(X_PGUP)));
        } else {
        }
        break;
    case FF_CT:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_TAP(X_W)));
        } else {
        }
        break;
    case FF_NT:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_TAP(X_T)));
        } else {
        }
        break;
    case FF_ADR:
        if (record->event.pressed) {
            SEND_STRING(SS_LCTL(SS_TAP(X_L)));
        } else {
        }
        break;
    }
    return true;
};
