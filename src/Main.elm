module Main exposing (..)

import Browser
import Browser.Navigation
import Html exposing (Html, div, h1, h2, img, text)
import Html.Attributes exposing (src)
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
    ( { page = Overview
      , key = key
      , entryRoute = parsePage url
      }
    , Cmd.none
    )



---- UPDATE ----


type Page
    = Overview
    | Day01


type Msg
    = ClickedLink Browser.UrlRequest
    | ChangedUrl Url


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
        ]


followRoute : Model -> ( Model, Cmd Msg )
followRoute model =
    case model.entryRoute of
        Just route ->
            case route of
                OverviewRoute ->
                    ( { model | page = Overview }, Cmd.none )

                Day01Route ->
                    ( { model | page = Day01 }, Cmd.none )

        Nothing ->
            ( { model | page = Overview }, Cmd.none )


type Route
    = OverviewRoute
    | Day01Route



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , h2 [] [ text "Really!" ]
        ]



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
