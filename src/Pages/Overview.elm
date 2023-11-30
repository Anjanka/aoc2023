module Pages.Overview exposing (..)

import Html exposing (Html, div, h1, h2, img, text)
import Html.Attributes exposing (src)


init : Model
init =
    ()


view : Model -> Html msg
view _ =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , h2 [] [ text "Really!" ]
        ]


type alias Model =
    ()
