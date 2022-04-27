/* Copyright 2019 Thomas Baart <thomas@splitkb.com>m
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H

// layer definitions
enum layers {
    _BASE = 0,
    _LY1,
    _LY2,
    _LY3,
    _LY4
};

#include "definitions.h"
#include "macros.c"
#include "g/keymap_combo.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

// -------------------------------------------------------------------------------------------------
// base layer: colemak-dh
// -------------------------------------------------------------------------------------------------

    [_BASE] = LAYOUT(
// ,-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------.
       KC_Q,   KC_W,   KC_F,   KC_P,   KC_B,        KC_J,   KC_L,   KC_U,   KC_Y,KC_LEAD,
// |-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------|
     A_LSFT, R_LALT, S_LCTL, T_LGUI,   KC_G,        KC_M, N_RGUI, E_RCTL, I_RALT, O_RSFT,
// |-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------|
       KC_Z,   KC_X,   KC_C,   KC_D,   KC_V,        KC_K,   KC_H,SM_LESS,SM_MORE,xxxxxxx,
// `-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------'
                            LY1_TAB,LY2_SPC,     LY3_ENT,LY4_BSP
//                         `-------+-------'    `-------+-------'
    ),

// -------------------------------------------------------------------------------------------------
// layer 1: numpad, symbols
// -------------------------------------------------------------------------------------------------

    [_LY1] = LAYOUT(
// ,-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------.
    SM_EQLS,   KC_4,   KC_5,   KC_6,SM_PLUS,     xxxxxxx,SM_LBRK,SM_RBRK,xxxxxxx,xxxxxxx,
// |-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------|
       KC_0,   KC_1,   KC_2,   KC_3, SM_DOT,     xxxxxxx,SM_LPAR,SM_RPAR,xxxxxxx,xxxxxxx,
// |-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------|
    SM_STAR,   KC_7,   KC_8,   KC_9,SM_MINS,     xxxxxxx,SM_LSBR,SM_RSBR,xxxxxxx,xxxxxxx,
// `-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------'
                            KC_RALT,KC_LSFT,     KC_LSFT,KC_RALT         
//                         `-------+-------'    `-------+-------'
    ),


// -------------------------------------------------------------------------------------------------
// layer 2: workspaces, vim macros, r macros
// -------------------------------------------------------------------------------------------------
 
    [_LY2] = LAYOUT(
// ,-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------.
     VIM_BD,   WS_4,   WS_5,   WS_6, VIM_WA,      R_TRUE,  R_LIB, R_INST,  R_GHI,xxxxxxx,
// |-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------|
    xxxxxxx,   WS_1,   WS_2,   WS_3, VIM_VS,      R_HERE,  R_FIL,  R_MUT,  R_SEL,xxxxxxx,
// |-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------|
     VIM_QA,   WS_7,   WS_8,   WS_9, VIM_HS,     R_FALSE,  R_FUN,   R_DF,  R_GGP,xxxxxxx,
// `-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------'
                            xxxxxxx,xxxxxxx,     KC_LSFT,xxxxxxx         
//                         `-------+-------'    `-------+-------'
    ),

// -------------------------------------------------------------------------------------------------
// layer 3: movement, kitty and firefox macros
// -------------------------------------------------------------------------------------------------

    [_LY3] = LAYOUT(
// ,-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------.
     KT_RNM,  KT_CT, KT_PRV, KT_NXT,  KT_NT,     xxxxxxx, VIM_CD, VIM_CU,xxxxxxx,xxxxxxx,
// |-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------|
     FF_ADR,  FF_CT, FF_PRV, FF_NXT,  FF_NT,     KC_LEFT,KC_DOWN,  KC_UP,KC_RGHT,xxxxxxx,
// |-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------|
    xxxxxxx,xxxxxxx,xxxxxxx,xxxxxxx,xxxxxxx,     xxxxxxx,KC_PGDN,KC_PGUP,xxxxxxx,xxxxxxx,
// `-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------'
                            xxxxxxx,xxxxxxx,     xxxxxxx,xxxxxxx         
//                         `-------+-------'    `-------+-------'
    ),

// ------------------
// functions 
// ------------------

    [_LY4] = LAYOUT(
// ,-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------.
      KC_F1,  KC_F2,  KC_F3,  KC_F4,xxxxxxx,     xxxxxxx, FN_CPY, FN_PST,xxxxxxx,xxxxxxx,
// |-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------|
      KC_F5,  KC_F6,  KC_F7,  KC_F8,xxxxxxx,     xxxxxxx,FN_SCPY,FN_SPST,xxxxxxx,xxxxxxx,
// |-------+-------+-------+-------+-------.    ,-------+-------+-------+-------+-------|
      KC_F9, KC_F10, KC_F11, KC_F12,xxxxxxx,     xxxxxxx,xxxxxxx,xxxxxxx,xxxxxxx,xxxxxxx,
// `-------+-------+-------+-------+-------|    |-------+-------+-------+-------+-------'
                            xxxxxxx,xxxxxxx,     xxxxxxx,xxxxxxx
//                         `-------+-------'    `-------+-------'
    )
};

bool get_combo_must_tap(uint16_t index, combo_t *combo) {
    // If you want all combos to be tap-only, just uncomment the next line
    // return true;

    // If you want *all* combos, that have Mod-Tap/Layer-Tap/Momentary keys in its chord, 
    // to be tap-only, this is for you:
    uint16_t key;
    uint8_t idx = 0;
    while ((key = pgm_read_word(&combo->keys[idx])) != COMBO_END) {
        switch (key) {
            case QK_MOD_TAP...QK_MOD_TAP_MAX:
            case QK_LAYER_TAP...QK_LAYER_TAP_MAX:
            case QK_MOMENTARY...QK_MOMENTARY_MAX:
                return true;
        }
        idx += 1;
    }
    return false;

}
