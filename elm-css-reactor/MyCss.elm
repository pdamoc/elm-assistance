module MyCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li, ul)
import Css.Namespace exposing (namespace)


type CssClasses
    = NavBar


type CssIds
    = Page


css : Stylesheet
css =
    (stylesheet << namespace "dreamwriter")
        [ body
            [ overflowX auto
            , minWidth (px 1280)
            ]
        , id Page
            [ backgroundColor (rgb 200 128 64)
            , color (hex "CCFFFF")
            , width (pct 100)
            , property "height" "100vh"
            , boxSizing borderBox
            , padding (px 8)
            , margin zero
            ]
        , class NavBar
            [ margin zero
            , padding (px 10)
            , backgroundColor (rgb 100 64 32)
            , descendants
                [ ul
                    [ margin zero
                    , padding zero
                    ]
                , li
                    [ (display inlineBlock) |> important
                    , color primaryAccentColor
                    , paddingLeft (px 5)
                    ]
                ]
            ]
        ]


primaryAccentColor : Color
primaryAccentColor =
    hex "ccffaa"
