module Pages.Day02 exposing (..)

import Html exposing (Html, button, div, h1, p, text, textarea)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)


init : Model
init =
    { content = ""
    , result = ""
    , result2 = ""
    }


view : Model -> Html Msg
view model =
    div []
        [ textarea [ placeholder "Please paste game records here.", value model.content, onInput Change ] []
        , h1 [] [ text "Part 1" ]
        , p []
            [ button [ onClick GetSumOfIDsOfPossibleGames ] [ text "Compute" ]
            , text (String.append "Result: " model.result)
            ]
        , h1 [] [ text "Part 2" ]
        , p []
            [ text "tba"
            ]
        ]


type alias Model =
    { content : String
    , result : String
    , result2 : String
    }


type Msg
    = Change String
    | GetSumOfIDsOfPossibleGames


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent, result = "" }

        GetSumOfIDsOfPossibleGames ->
            { model | result = "" }
