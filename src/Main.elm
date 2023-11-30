module Main exposing (..)

import Browser
import Browser.Navigation
import Html exposing (Html, div, h1, h2, img, text)
import Html.Attributes exposing (src)
import Url exposing (Url)



---- MODEL ----


type alias Model =
    { key : Browser.Navigation.Key
    , page : Page
    }


init : Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init url key =
    ( { page = Overview
      , key = key
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
    ( model, Cmd.none )



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
