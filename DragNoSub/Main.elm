module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on)
import Json.Decode as Json exposing (field)
import Mouse exposing (Position)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions =
            \_ -> Sub.none
            --subscriptions
        }



-- MODEL


type alias Model =
    { position : Position
    , drag : Maybe Drag
    }


type alias Drag =
    { start : Position
    , current : Position
    }


init : ( Model, Cmd Msg )
init =
    ( Model (Position 200 200) Nothing, Cmd.none )



-- UPDATE


type Msg
    = DragStart Position
    | DragAt Position
    | DragEnd Position


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateHelp msg model, Cmd.none )


updateHelp : Msg -> Model -> Model
updateHelp msg ({ position, drag } as model) =
    case msg of
        DragStart xy ->
            Model position (Just (Drag xy xy))

        DragAt xy ->
            Model position (Maybe.map (\{ start } -> Drag start xy) drag)

        DragEnd _ ->
            Model (getPosition model) Nothing



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.drag of
        Nothing ->
            Sub.none

        Just _ ->
            Sub.batch [ Mouse.moves DragAt, Mouse.ups DragEnd ]



-- VIEW


offsetPosition : Json.Decoder Position
offsetPosition =
    Json.map2 Position
        (field "offsetX" Json.int)
        (field "offsetY" Json.int)


onWithPosition : String -> (Position -> msg) -> Attribute msg
onWithPosition evt msg =
    on evt (Json.map msg offsetPosition)


onMouseDown : Attribute Msg
onMouseDown =
    onWithPosition "mousedown" DragStart


onMouseUp : Attribute Msg
onMouseUp =
    onWithPosition "mouseup" DragEnd


onMouseMove : Attribute Msg
onMouseMove =
    onWithPosition "mousemove" DragAt


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


view : Model -> Html Msg
view model =
    let
        realPosition =
            getPosition model
    in
        div
            [ onMouseDown
            , onMouseMove
            , onMouseUp
            , style
                [ "background-color" => "#3C8D2F"
                , "cursor" => "move"
                , "width" => "100px"
                , "height" => "100px"
                , "border-radius" => "4px"
                , "position" => "absolute"
                , "left" => px realPosition.x
                , "top" => px realPosition.y
                , "color" => "white"
                , "display" => "flex"
                , "align-items" => "center"
                , "justify-content" => "center"
                ]
            ]
            [ text "Drag Me!"
            ]


px : Int -> String
px number =
    toString number ++ "px"


getPosition : Model -> Position
getPosition { position, drag } =
    case drag of
        Nothing ->
            position

        Just { start, current } ->
            Position
                (position.x + current.x - start.x)
                (position.y + current.y - start.y)



--onMouseDown : Attribute Msg
--onMouseDown =
--  on "mousedown" (Json.map DragStart Mouse.position)
