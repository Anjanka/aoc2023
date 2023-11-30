module Pages.Day01 exposing (..)

import Html exposing (Html, div, h1, text)


init : Model
init =
    ()


view : Model -> Html msg
view _ =
    div []
        [ h1 [] [ text "Part 1" ]
        , text "tba"
        , h1 [] [ text "Part 2" ]
        , text "tba"
        ]


type alias Model =
    ()
