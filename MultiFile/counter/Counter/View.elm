module Counter.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


-- TYPE IMPORTS

import Counter.Model exposing (Model)
import Counter.Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [ countStyle ] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]


countStyle : Attribute Msg
countStyle =
    style
        [ ( "font-size", "20px" )
        , ( "font-family", "monospace" )
        , ( "display", "inline-block" )
        , ( "width", "50px" )
        , ( "text-align", "center" )
        ]
