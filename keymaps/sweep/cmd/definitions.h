#pragma once

// --------------------------------
// no key
// --------------------------------

#define xxxxxxx KC_NO

// --------------------------------
// homerow mods
// --------------------------------

#define A_LSFT MT(MOD_LSFT, KC_A)
#define R_LALT MT(MOD_LALT, KC_R)
#define S_LCTL MT(MOD_LCTL, KC_S)
#define T_LGUI MT(MOD_LGUI, KC_T)

#define N_RGUI MT(MOD_RGUI, KC_N)
#define E_RCTL MT(MOD_RCTL, KC_E)
#define I_RALT MT(MOD_RALT, KC_I)
#define O_RSFT MT(MOD_RSFT, KC_O)

// --------------------------------
// layer taps
// --------------------------------

#define NUM_TAB LT(_NUM, KC_TAB)
#define WFL_SPC LT(_WFL, KC_SPC)
#define NAV_ENT LT(_NAV, KC_ENT)
#define FUN_BSP LT(_FUN, KC_BSPC)

// --------------------------------
// symbol definitions based on 
// swedish keyboard layout
// --------------------------------

#define SM_DOT  KC_DOT         // . 
#define SM_PLUS KC_MINS        // + 
#define SM_SQUO KC_NUHS        // '
#define SM_MINS KC_SLSH        // -
#define SM_LESS KC_NUBS        // <

// shifted symbols
#define SM_EXCL S(KC_1)        // !
#define SM_DQUO S(KC_2)        // "
#define SM_HASH S(KC_3)        // # 
#define SM_PERC S(KC_5)        // % 
#define SM_AND  S(KC_6)        // &
#define SM_FSLS S(KC_7)        // /
#define SM_LPAR S(KC_8)        // (
#define SM_RPAR S(KC_9)        // )
#define SM_EQLS S(KC_0)        // =
#define SM_STAR S(KC_NUHS)     // *
#define SM_COLN S(KC_DOT)      // :
#define SM_SCOL S(KC_COMM)     // ;
#define SM_UNDR S(KC_SLSH)     // _
#define SM_QUES S(KC_MINS)     // ?
#define SM_MORE S(KC_NUBS)     // >

// alt-gr symbols
#define SM_AT   ALGR(KC_2)     // @
#define SM_DOLR ALGR(KC_4)     // $
#define SM_LSBR ALGR(KC_7)     // {
#define SM_LBRK ALGR(KC_8)     // [
#define SM_RBRK ALGR(KC_9)     // ]
#define SM_RSBR ALGR(KC_0)     // }
#define SM_PIPE ALGR(KC_NUBS)  // |
#define SM_BSLS ALGR(KC_MINS)

// --------------------------------
// linux workspace movement using
// super + number
// --------------------------------

#define WS_1 G(KC_1)
#define WS_2 G(KC_2)
#define WS_3 G(KC_3)
#define WS_4 G(KC_4)
#define WS_5 G(KC_5)
#define WS_6 G(KC_6)
#define WS_7 G(KC_7)
#define WS_8 G(KC_8)
#define WS_9 G(KC_9)
