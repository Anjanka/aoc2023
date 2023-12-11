module Pages.Day01 exposing (..)

import Html exposing (Html, div, h1, input, text, textarea)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)


init : Model
init =
    { content = "" }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Part 1" ]
        , textarea [ placeholder "Please paste calibration document here.", value model.content, onInput Change ] []
        , h1 [] [ text "Part 2" ]
        , text "tba"
        ]


type alias Model =
    { content : String }


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }
