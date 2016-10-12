port module Main exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes


main =
    program
        { init = ( "", Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> receiveString UpdateText
        }


type Msg
    = GetSvg
    | UpdateText String


update msg model =
    case msg of
        GetSvg ->
            ( model, requestString "svg" )

        UpdateText val ->
            ( val, Cmd.none )


port requestString : String -> Cmd msg


port receiveString : (String -> msg) -> Sub msg


view model =
    div []
        [ div [ id "svg" ]
            [ svg
                [ width "120", height "120", viewBox "0 0 120 120" ]
                [ rect [ x "10", y "10", width "100", height "100", rx "15", ry "15", fill "red" ] [] ]
            ]
        , button [ onClick GetSvg ] [ Html.text "getValue" ]
        , div [] [ Html.text model ]
        ]
