module WithParts exposing (..)

import Html exposing (..)
import Html.Attributes exposing (type', style)
import Html.App as App


-- MATERIAL DESIGN

import Material
import Material.Options as Options exposing (cs, css)
import Material.Textfield as Textfield
import Material.Button as Button
import Material.Toggles as Toggles
import Material.Grid exposing (grid, cell, size, Cell, Device(..), Align(..), align, offset, noSpacing)
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation


-- WIRING


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL


type alias UserData =
    { fullName : String
    , company : String
    , email : String
    , phone : String
    , addressLine1 : String
    , addressLine2 : String
    , city : String
    , state : String
    , country : String
    , premium : Bool
    }


emptyUserData : UserData
emptyUserData =
    { fullName = ""
    , company = ""
    , email = ""
    , phone = ""
    , addressLine1 = ""
    , addressLine2 = ""
    , city = ""
    , state = ""
    , country = ""
    , premium = False
    }


type alias Model =
    { userData : UserData
    , submitedData : String
    , mdl : Material.Model
    }


init : ( Model, Cmd a )
init =
    ( Model emptyUserData "" Material.model, Cmd.none )



-- UPDATE


type DataChange
    = FullName String
    | Company String
    | Email String
    | Telephone String
    | AddressLine1 String
    | AddressLine2 String
    | City String
    | State String
    | Country String
    | Premium


type Msg
    = UserDataChanged DataChange
    | Submit
    | Noop
    | Mdl (Material.Msg Msg)


updateUser : DataChange -> UserData -> UserData
updateUser msg user =
    case msg of
        FullName str ->
            { user | fullName = str }

        Company str ->
            { user | company = str }

        Email str ->
            { user | email = str }

        Telephone str ->
            { user | phone = str }

        AddressLine1 str ->
            { user | addressLine1 = str }

        AddressLine2 str ->
            { user | addressLine2 = str }

        City str ->
            { user | city = str }

        State str ->
            { user | state = str }

        Country str ->
            { user | country = str }

        Premium ->
            { user | premium = not user.premium }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserDataChanged dMsg ->
            ( { model | userData = updateUser dMsg model.userData }, Cmd.none )

        Submit ->
            ( { model | submitedData = toString model.userData }, Cmd.none )

        Noop ->
            ( model, Cmd.none )

        Mdl mdlMsg ->
            Material.update mdlMsg model



-- VIEW


view : Model -> Html Msg
view model =
    let
        user =
            model.userData

        textField idx lbl val msg =
            Textfield.render Mdl
                idx
                model.mdl
                [ Textfield.label lbl
                , Textfield.floatingLabel
                , Textfield.text'
                , Textfield.value val
                , Textfield.onInput (UserDataChanged << msg)
                , css "width" "100%"
                ]

        fullName =
            textField [ 1 ] "Full Name" user.fullName FullName

        company =
            textField [ 2 ] "Company" user.company Company

        email =
            textField [ 3 ] "email" user.email Email

        phone =
            textField [ 4 ] "Phone" user.phone Telephone

        addressLine1 =
            textField [ 5 ] "Address Line One" user.addressLine1 AddressLine1

        addressLine2 =
            textField [ 6 ] "Address Line Two" user.addressLine2 AddressLine2

        city =
            textField [ 7 ] "City" user.city City

        state =
            textField [ 8 ] "State" user.state State

        country =
            textField [ 9 ] "Country" user.country Country

        premium =
            Toggles.switch Mdl
                [ 10 ]
                model.mdl
                [ Toggles.onClick (UserDataChanged Premium)
                , Toggles.ripple
                , Toggles.value user.premium
                ]
                [ text "Premium Package" ]

        submit =
            Button.render Mdl
                [ 11 ]
                model.mdl
                [ Button.colored
                , Button.raised
                , Button.ripple
                , css "marginRight" "8px"
                , css "marginLeft" "8px"
                , Button.onClick Submit
                ]
                [ text "Submit" ]
    in
        div
            [ style
                [ ( "background-color", "#eee" )
                , ( "min-height", "100vh" )
                , ( "padding", "40px" )
                ]
            ]
            [ Card.view
                [ css "width" "800px"
                , css "margin" "auto"
                , Elevation.e2
                ]
                [ Card.media [ Color.background (Color.white) ]
                    [ grid
                        []
                        [ fullRow fullName
                        , fullRow company
                        , halfRow email
                        , halfRow phone
                        , fullRow addressLine1
                        , fullRow addressLine2
                        , halfRow city
                        , halfRow state
                        , fullRow country
                        , fullRow premium
                        , fullRow (hr [] [])
                        , fullRow (rightAlignedDiv submit)
                        ]
                    ]
                ]
            , div [] [ text model.submitedData ]
            ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



--- MATERIAL EXTRAS


all : Int -> Options.Style a
all =
    size All


desktop : Int -> Options.Style a
desktop =
    size Desktop


tablet : Int -> Options.Style a
tablet =
    size Tablet


phone : Int -> Options.Style a
phone =
    size Phone


fullRow : Html a -> Cell a
fullRow w =
    cell [ desktop 12, tablet 8, phone 4, align Middle ] [ w ]


halfRow : Html a -> Cell a
halfRow w =
    cell [ desktop 6, tablet 4, phone 4 ] [ w ]


rightAlignedDiv : Html a -> Html a
rightAlignedDiv item =
    div [ style [ ( "display", "flex" ), ( "justify-content", "flex-end" ) ] ] [ item ]
