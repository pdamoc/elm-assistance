module Counter exposing (..)

import Html exposing (Html)


-- IMPORTS

import Counter.Model as Model
import Counter.Update as Update
import Counter.View as View


-- MODEL


type alias Model =
    Model.Model


init : Int -> Model
init =
    Model.init



-- UPDATE


type alias Msg =
    Update.Msg


update : Msg -> Model -> Model
update =
    Update.update



-- VIEW


view : Model -> Html Msg
view =
    View.view
