module Pages.Day01 exposing (..)

import Html exposing (Html, button, div, h1, p, text, textarea)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import List.Extra


init : Model
init =
    { content = ""
    , result = ""
    }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Part 1" ]
        , textarea [ placeholder "Please paste calibration document here.", value model.content, onInput Change ] []
        , p []
            [ button [ onClick GetSumOfCalibrationValues ] [ text "Compute" ]
            , text (String.append "Result: " model.result)
            ]
        , h1 [] [ text "Part 2" ]
        , text "tba"
        ]


type alias Model =
    { content : String
    , result : String
    }


type Msg
    = Change String
    | GetSumOfCalibrationValues


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent, result = "" }

        GetSumOfCalibrationValues ->
            { model | result = getSumOfCalibrationValues model.content }


getSumOfCalibrationValues : String -> String
getSumOfCalibrationValues calDoc =
    calDoc
        |> String.lines
        |> List.map getCalibrationValue
        |> List.sum
        |> String.fromInt


getCalibrationValue : String -> Int
getCalibrationValue calDocLine =
    let
        digitsFromString =
            searchForDigits calDocLine
    in
    case ( List.head digitsFromString, List.Extra.last digitsFromString ) of
        ( Just first, Just last ) ->
            10 * first + last

        _ ->
            0



--todo: fuse maps


searchForDigits : String -> List Int
searchForDigits calDocLine =
    calDocLine
        |> String.toList
        |> List.filter Char.isDigit
        |> List.map
            (\c ->
                String.fromList [ c ]
                    |> String.toInt
                    |> (\maybeInt -> Maybe.withDefault 0 maybeInt)
            )
