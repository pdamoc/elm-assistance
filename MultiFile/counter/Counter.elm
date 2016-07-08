module Counter exposing (Model, Msg, init, update, view)

import Html exposing (Html)


-- IMPORTS

import Counter.Model as Model
import Counter.Update as Update
import Counter.View as View
import Counter.Types as Types


-- MODEL


type alias Model =
    Types.Model


init : Int -> Model
init =
    Model.init



-- UPDATE


type alias Msg =
    Types.Msg


update : Msg -> Model -> Model
update =
    Update.update



-- VIEW


view : Model -> Html Msg
view =
    View.view
