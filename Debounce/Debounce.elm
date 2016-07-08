module Debounce exposing (..)

import Time exposing (Time)
import AnimationFrame


type alias Model todo =
    { elapsed : Maybe Time
    , interval : Time
    , todo : Maybe todo
    }


init : Time -> Model todo
init interval =
    { elapsed = Nothing
    , interval = interval
    , todo = Nothing
    }


update : Time -> Model todo -> ( Model todo, Maybe todo )
update time model =
    let
        newModel =
            { model | elapsed = Maybe.map (\t -> t + time) model.elapsed }
    in
        case newModel.elapsed of
            Nothing ->
                ( newModel, Nothing )

            Just t ->
                if t > model.interval then
                    ( { newModel | elapsed = Nothing, todo = Nothing }, model.todo )
                else
                    ( newModel, Nothing )


bounce : todo -> Model todo -> Model todo
bounce todo model =
    { model | elapsed = Just 0, todo = Just todo }


subscriptions : (Time -> pMsg) -> Model todo -> Sub pMsg
subscriptions tagger model =
    case model.elapsed of
        Nothing ->
            Sub.none

        Just _ ->
            AnimationFrame.diffs tagger
