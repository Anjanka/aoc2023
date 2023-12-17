module Main exposing (..)

import Browser
import Browser.Navigation
import Html exposing (Html)
import Pages.Day01 as Day01
import Pages.Day02 as Day02
import Pages.Day03 as Day03
import Pages.Overview
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, s)



---- MODEL ----


type alias Model =
    { key : Browser.Navigation.Key
    , page : Page
    , entryRoute : Maybe Route
    }


init : Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init url key =
    { page = Overview
    , key = key
    , entryRoute = parsePage url
    }
        |> followRoute



---- UPDATE ----


type Page
    = Overview
    | Day01 Day01.Model
    | Day02 Day02.Model
    | Day03 Day03.Model


type Msg
    = ClickedLink Browser.UrlRequest
    | ChangedUrl Url
    | Day01Msg Day01.Msg
    | Day02Msg Day02.Msg
    | Day03Msg Day03.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Browser.Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Browser.Navigation.load href )

        ChangedUrl url ->
            { model | entryRoute = url |> parsePage }
                |> followRoute

        Day01Msg day01Msg ->
            case model.page of
                Day01 day01 ->
                    let
                        newModel =
                            Day01.update day01Msg day01
                    in
                    ( { model | page = Day01 newModel }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        Day02Msg day02Msg ->
            case model.page of
                Day02 day02 ->
                    let
                        newModel =
                            Day02.update day02Msg day02
                    in
                    ( { model | page = Day02 newModel }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        Day03Msg day03Msg ->
            case model.page of
                Day03 day03 ->
                    let
                        newModel =
                            Day03.update day03Msg day03
                    in
                    ( { model | page = Day03 newModel }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


parsePage : Url -> Maybe Route
parsePage =
    fragmentToPath >> Parser.parse parser


fragmentToPath : Url -> Url
fragmentToPath url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map OverviewRoute Parser.top
        , Parser.map Day01Route (s "day01")
        , Parser.map Day02Route (s "day02")
        , Parser.map Day03Route (s "day03")
        ]


followRoute : Model -> ( Model, Cmd Msg )
followRoute model =
    case model.entryRoute of
        Just route ->
            case route of
                OverviewRoute ->
                    ( { model | page = Overview }, Cmd.none )

                Day01Route ->
                    ( { model | page = Day01 Day01.init }, Cmd.none )

                Day02Route ->
                    ( { model | page = Day02 Day02.init }, Cmd.none )

                Day03Route ->
                    ( { model | page = Day03 Day03.init }, Cmd.none )

        Nothing ->
            ( { model | page = Overview }, Cmd.none )


type Route
    = OverviewRoute
    | Day01Route
    | Day02Route
    | Day03Route



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.page of
        Overview ->
            Pages.Overview.view Pages.Overview.init

        Day01 day01 ->
            Day01.view day01 |> Html.map Day01Msg

        Day02 day02 ->
            Day02.view day02 |> Html.map Day02Msg

        Day03 day03 ->
            Day03.view day03 |> Html.map Day03Msg



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { view = \model -> { title = "aoc2023", body = [ view model ] }
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }
