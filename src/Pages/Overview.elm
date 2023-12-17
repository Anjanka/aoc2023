module Pages.Overview exposing (..)

import Html exposing (Html, a, div, h1, h2, img, p, text)
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
        , p []
            [ a [ href "#/day01" ] [ text "Day01" ]
            ]
        , p []
            [ a [ href "#/day02" ] [ text "Day02" ]
            ]
        , p
            []
            [ a [ href "#/day03" ] [ text "Day03" ]
            ]
        ]


type alias Model =
    ()
