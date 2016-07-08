module Counter.Update exposing (update, Msg(..))

import Counter.Model exposing (Model)


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1
