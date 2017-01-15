module Main exposing (..)

import Html exposing (..)
import Form


main : Program Never Model Msg
main =
    program
        { init = ( Model Form.init Nothing, Cmd.none )
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { form : Form.PersonInput
    , submitted : Maybe Form.PersonInput
    }


type Msg
    = FormUpdate Form.PersonInput
    | Submit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FormUpdate formState ->
            ( { model | form = formState }, Cmd.none )

        Submit ->
            ( { model | submitted = Just model.form }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ Form.personInputForm { onUpdate = FormUpdate, onSubmit = Submit } model.form
        , case model.submitted of
            Nothing ->
                div [] [ text "Enter something in the form and submit" ]

            Just form ->
                div [] [ text ("The following data was submitted: " ++ (toString form)) ]
        ]
