module Pages.Day01 exposing (..)

import Html exposing (Html, button, div, h1, p, text, textarea)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import List.Extra


init : Model
init =
    { content = ""
    , result = ""
    , result2 = ""
    }


view : Model -> Html Msg
view model =
    div []
        [ textarea [ placeholder "Please paste calibration document here.", value model.content, onInput Change ] []
        , h1 [] [ text "Part 1" ]
        , p []
            [ button [ onClick GetSumOfCalibrationValues ] [ text "Compute" ]
            , text (String.append "Result: " model.result)
            ]
        , h1 [] [ text "Part 2" ]
        , p []
            [ button [ onClick GetSumOfCalibrationValuesPart2 ] [ text "Compute" ]
            , text (String.append "Result: " model.result2)
            ]
        ]


type alias Model =
    { content : String
    , result : String
    , result2 : String
    }


type Msg
    = Change String
    | GetSumOfCalibrationValues
    | GetSumOfCalibrationValuesPart2


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent, result = "" }

        GetSumOfCalibrationValues ->
            { model | result = getSumOfCalibrationValues model.content }

        GetSumOfCalibrationValuesPart2 ->
            { model | result2 = getSumOfCalibrationValuesPart2 model.content }


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


getSumOfCalibrationValuesPart2 : String -> String
getSumOfCalibrationValuesPart2 calDoc =
    calDoc
        |> String.lines
        |> List.map getCalibrationValuePart2
        |> List.sum
        |> String.fromInt


getCalibrationValuePart2 : String -> Int
getCalibrationValuePart2 calDocLine =
    10 * searchForDigits2 String.left calDocLine 1 + searchForDigits2 String.right calDocLine 1


searchForDigits2 : (Int -> String -> String) -> String -> Int -> Int
searchForDigits2 makePartialString calDocLine sizeOfPart =
    if String.length calDocLine < sizeOfPart then
        0

    else
        let
            partialString =
                makePartialString sizeOfPart calDocLine
        in
        if String.contains "1" partialString || String.contains "one" partialString then
            1

        else if String.contains "2" partialString || String.contains "two" partialString then
            2

        else if String.contains "3" partialString || String.contains "three" partialString then
            3

        else if String.contains "4" partialString || String.contains "four" partialString then
            4

        else if String.contains "5" partialString || String.contains "five" partialString then
            5

        else if String.contains "6" partialString || String.contains "six" partialString then
            6

        else if String.contains "7" partialString || String.contains "seven" partialString then
            7

        else if String.contains "8" partialString || String.contains "eight" partialString then
            8

        else if String.contains "9" partialString || String.contains "nine" partialString then
            9

        else
            searchForDigits2 makePartialString calDocLine (sizeOfPart + 1)
