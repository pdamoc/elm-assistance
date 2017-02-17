module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href)
import Html.CssHelpers
import MyCss exposing (..)
import Utils exposing (withCss)


{ id, class, classList } =
    Html.CssHelpers.withNamespace "dreamwriter"


main : Html msg
main =
    div []
        [ div [ class [ NavBar ] ]
            [ ul []
                [ li [] [ text " Welcome to the NavBar " ]
                , li [] [ a [ href "#" ] [ text "About" ] ]
                , li [] [ a [ href "#" ] [ text "Contact" ] ]
                ]
            ]
        , div [ id Page ] [ text "this has the Page id" ]
        ]
        |> withCss css



-- Utils
