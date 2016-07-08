module Counter.Model exposing (Model, init)


type alias Model =
    Int


init : Int -> Model
init v =
    v
