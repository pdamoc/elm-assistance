module Form exposing (..)

import Html exposing (Html, div, input, button, text)
import Html.Attributes exposing (placeholder, value, type_)
import Html.Events exposing (onClick, onInput)


-- The contents of the form


type alias PersonInput =
    { firstName : String
    , lastName : String
    }


init : PersonInput
init =
    PersonInput "" ""


type alias Config msg =
    { onUpdate : PersonInput -> msg
    , onSubmit : msg
    }


personInputForm : Config msg -> PersonInput -> Html msg
personInputForm config personInput =
    let
        onFirstName =
            onInput (\str -> config.onUpdate { personInput | firstName = str })

        onLastName =
            onInput (\str -> config.onUpdate { personInput | lastName = str })
    in
        div []
            [ input [ type_ "text", placeholder "First Name", onFirstName, value personInput.firstName ] []
            , input [ type_ "text", placeholder "Last Name", onLastName, value personInput.lastName ] []
            , button [ onClick config.onSubmit ] [ text "Submit" ]
            ]
