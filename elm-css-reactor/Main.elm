module Main exposing (..)

import Html exposing (Html)
import Html.CssHelpers
import MyCss exposing (..)
import Utils exposing (withCss)


{ id, class, classList } =
    Html.CssHelpers.withNamespace "dreamwriter"


main : Html msg
main =
    Html.div []
        [ Html.div [ class [ NavBar ] ]
            [ Html.ul []
                [ Html.li [] [ Html.text "About" ]
                , Html.li [] [ Html.text "Contact" ]
                ]
            ]
        , Html.div [ id Page ] [ Html.text "this has the Page id" ]
        ]
        |> withCss css



-- Utils
