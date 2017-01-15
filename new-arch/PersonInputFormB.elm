module PersonInputFormB exposing (..)

import Html exposing (Html, Attribute, div, input, button, text)
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


type Msg
    = FirstNameUpdated String
    | LastNameUpdated String


update : Msg -> PersonInput -> PersonInput
update msg model =
    case msg of
        FirstNameUpdated str ->
            { model | firstName = str }

        LastNameUpdated str ->
            { model | lastName = str }


onUpdate : (PersonInput -> msg) -> (String -> Msg) -> PersonInput -> Attribute msg
onUpdate lifter tagger model =
    onInput (tagger >> ((flip update) model) >> lifter)


personInputForm : Config msg -> PersonInput -> Html msg
personInputForm config personInput =
    let
        onFirstName =
            onUpdate config.onUpdate FirstNameUpdated personInput

        onLastName =
            onUpdate config.onUpdate LastNameUpdated personInput
    in
        div []
            [ input [ type_ "text", placeholder "First Name", onFirstName, value personInput.firstName ] []
            , input [ type_ "text", placeholder "Last Name", onLastName, value personInput.lastName ] []
            , button [ onClick config.onSubmit ] [ text "Submit" ]
            ]
