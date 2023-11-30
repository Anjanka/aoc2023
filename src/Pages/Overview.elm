module Pages.Overview exposing (..)

import Html exposing (Html, a, div, h1, h2, img, text)
import Html.Attributes exposing (href, src)


init : Model
init =
    ()


view : Model -> Html msg
view _ =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , h2 [] [ text "Really!" ]
        , a [ href "#/day01" ] [ text "Day01" ]
        ]


type alias Model =
    ()
