module WithoutParts exposing (..)

import Html exposing (..)
import Html.Attributes exposing (type', style)
import Html.App as App


-- MATERIAL DESIGN

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


type alias UserDataModels =
    { fullName : Textfield.Model
    , company : Textfield.Model
    , email : Textfield.Model
    , phone : Textfield.Model
    , addressLine1 : Textfield.Model
    , addressLine2 : Textfield.Model
    , city : Textfield.Model
    , state : Textfield.Model
    , country : Textfield.Model
    , premium : Toggles.Model
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


type alias MdlModel =
    { userData : UserDataModels
    , submit : Button.Model
    }


type alias Model =
    { userData : UserData
    , submitedData : String
    , mdl : MdlModel
    }


initMdlModel : MdlModel
initMdlModel =
    { userData =
        { fullName = Textfield.defaultModel
        , company = Textfield.defaultModel
        , email = Textfield.defaultModel
        , phone = Textfield.defaultModel
        , addressLine1 = Textfield.defaultModel
        , addressLine2 = Textfield.defaultModel
        , city = Textfield.defaultModel
        , state = Textfield.defaultModel
        , country = Textfield.defaultModel
        , premium = Toggles.defaultModel
        }
    , submit = Button.defaultModel
    }


init : ( Model, Cmd a )
init =
    ( Model emptyUserData "" initMdlModel, Cmd.none )



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
    | Mdl MdlMsg


type MdlMsg
    = SubmitMld Button.Msg
    | UserDataMdl DataChangeMdl


type DataChangeMdl
    = FullNameMdl Textfield.Msg
    | CompanyMdl Textfield.Msg
    | EmailMdl Textfield.Msg
    | TelephoneMdl Textfield.Msg
    | AddressLine1Mdl Textfield.Msg
    | AddressLine2Mdl Textfield.Msg
    | CityMdl Textfield.Msg
    | StateMdl Textfield.Msg
    | CountryMdl Textfield.Msg
    | PremiumMdl Toggles.Msg


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
update msg ({ mdl } as model) =
    case msg of
        UserDataChanged dMsg ->
            ( { model | userData = updateUser dMsg model.userData }, Cmd.none )

        Submit ->
            ( { model | submitedData = toString model.userData }, Cmd.none )

        Noop ->
            ( model, Cmd.none )

        Mdl mdlMsg ->
            case mdlMsg of
                SubmitMld cMsg ->
                    let
                        ( newSubmit, cmd ) =
                            Button.update cMsg mdl.submit

                        newMdl =
                            { mdl | submit = newSubmit }
                    in
                        ( { model | mdl = newMdl }, Cmd.map (Mdl << SubmitMld) cmd )

                UserDataMdl cMsg ->
                    let
                        ( newUserData, cmd ) =
                            updateUserDataMdl cMsg mdl.userData

                        newMdl =
                            { mdl | userData = newUserData }
                    in
                        ( { model | mdl = newMdl }, Cmd.map (Mdl << UserDataMdl) cmd )


updateUserDataMdl : DataChangeMdl -> UserDataModels -> ( UserDataModels, Cmd DataChangeMdl )
updateUserDataMdl msg user =
    case msg of
        FullNameMdl cMsg ->
            let
                newChildModel =
                    Textfield.update cMsg user.fullName
            in
                ( { user | fullName = newChildModel }, Cmd.none )

        CompanyMdl cMsg ->
            let
                newChildModel =
                    Textfield.update cMsg user.company
            in
                ( { user | company = newChildModel }, Cmd.none )

        EmailMdl cMsg ->
            let
                newChildModel =
                    Textfield.update cMsg user.email
            in
                ( { user | email = newChildModel }, Cmd.none )

        TelephoneMdl cMsg ->
            let
                newChildModel =
                    Textfield.update cMsg user.phone
            in
                ( { user | phone = newChildModel }, Cmd.none )

        AddressLine1Mdl cMsg ->
            let
                newChildModel =
                    Textfield.update cMsg user.addressLine1
            in
                ( { user | addressLine1 = newChildModel }, Cmd.none )

        AddressLine2Mdl cMsg ->
            let
                newChildModel =
                    Textfield.update cMsg user.addressLine2
            in
                ( { user | addressLine2 = newChildModel }, Cmd.none )

        CityMdl cMsg ->
            let
                newChildModel =
                    Textfield.update cMsg user.city
            in
                ( { user | city = newChildModel }, Cmd.none )

        StateMdl cMsg ->
            let
                newChildModel =
                    Textfield.update cMsg user.state
            in
                ( { user | state = newChildModel }, Cmd.none )

        CountryMdl cMsg ->
            let
                newChildModel =
                    Textfield.update cMsg user.country
            in
                ( { user | country = newChildModel }, Cmd.none )

        PremiumMdl cMsg ->
            let
                ( newFullName, cmd ) =
                    Toggles.update cMsg user.premium
            in
                ( { user | premium = newFullName }, Cmd.map PremiumMdl cmd )



-- VIEW


view : Model -> Html Msg
view model =
    let
        user =
            model.userData

        userMdl =
            model.mdl.userData

        textField lbl val model msg lift =
            Textfield.view (Mdl << UserDataMdl << lift)
                model
                [ Textfield.label lbl
                , Textfield.floatingLabel
                , Textfield.text'
                , Textfield.value val
                , Textfield.onInput (UserDataChanged << msg)
                , css "width" "100%"
                ]

        fullName =
            textField "Full Name" user.fullName userMdl.fullName FullName FullNameMdl

        company =
            textField "Company" user.company userMdl.company Company CompanyMdl

        email =
            textField "email" user.email userMdl.email Email EmailMdl

        phone =
            textField "Phone" user.phone userMdl.phone Telephone TelephoneMdl

        addressLine1 =
            textField "Address Line One" user.addressLine1 userMdl.addressLine1 AddressLine1 AddressLine1Mdl

        addressLine2 =
            textField "Address Line Two" user.addressLine2 userMdl.addressLine2 AddressLine2 AddressLine2Mdl

        city =
            textField "City" user.city userMdl.city City CityMdl

        state =
            textField "State" user.state userMdl.state State StateMdl

        country =
            textField "Country" user.country userMdl.country Country CountryMdl

        premium =
            Toggles.viewSwitch (Mdl << UserDataMdl << PremiumMdl)
                userMdl.premium
                [ Toggles.onClick (UserDataChanged Premium)
                , Toggles.ripple
                , Toggles.value user.premium
                ]
                [ text "Premium Package" ]

        submit =
            Button.view (Mdl << SubmitMld)
                model.mdl.submit
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
