module Main exposing (..)

import Html exposing (..)
import Html.Events as E
import Time exposing (Time, second)
import Debounce exposing (bounce)


main : Program Never Model Msg
main =
    program
        { init = ( init, Cmd.none )
        , update = \msg mdl -> ( update msg mdl, Cmd.none )
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


debounceTime : Time
debounceTime =
    second


type alias Model =
    { text : String
    , sentText : String
    , debounce : Debounce.Model Msg
    }


init : Model
init =
    Model "" "" (Debounce.init debounceTime)



-- UPDATE


type Msg
    = UpdateText String
    | DebounceMsg Time
    | SomeAction


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateText str ->
            { model | text = str, debounce = Debounce.bounce SomeAction model.debounce }

        DebounceMsg dMsg ->
            case (Debounce.update dMsg model.debounce) of
                ( newDebounce, Nothing ) ->
                    { model | debounce = newDebounce }

                ( newDebounce, Just nMsg ) ->
                    update nMsg { model | debounce = newDebounce }

        SomeAction ->
            { model | sentText = model.text }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Type Something! " ]
        , input [ E.onInput UpdateText ] []
        , div [] [ text model.sentText ]
        ]



-- VIEW


subscriptions : Model -> Sub Msg
subscriptions model =
    Debounce.subscriptions DebounceMsg model.debounce
