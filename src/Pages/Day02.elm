module Pages.Day02 exposing (..)

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
        [ textarea [ placeholder "Please paste game records here.", value model.content, onInput Change ] []
        , h1 [] [ text "Part 1" ]
        , p []
            [ button [ onClick GetSumOfIDsOfPossibleGames ] [ text "Compute" ]
            , text (String.append "Result: " model.result)
            ]
        , h1 [] [ text "Part 2" ]
        , p []
            [ button [ onClick GetSumOfPowerOfMinimalCubeSets ] [ text "Compute" ]
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
    | GetSumOfIDsOfPossibleGames
    | GetSumOfPowerOfMinimalCubeSets


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent, result = "", result2 = "" }

        GetSumOfIDsOfPossibleGames ->
            { model | result = getSumOfIDsOfPossibleGames model.content }

        GetSumOfPowerOfMinimalCubeSets ->
            { model | result2 = getSumOfPowerOfMinimalCubeSets model.content }


getSumOfIDsOfPossibleGames : String -> String
getSumOfIDsOfPossibleGames gameRecs =
    gameRecs
        |> String.lines
        |> List.map getIDsOfPossibleGames
        |> List.sum
        |> String.fromInt


getIDsOfPossibleGames : String -> Int
getIDsOfPossibleGames gameRec =
    let
        justCubeValues =
            gameRec
                |> (\g -> String.replace ";" "," g)
                |> (\g -> String.split ":" g)
                |> List.Extra.last
                |> (\maybeString -> Maybe.withDefault "" maybeString)
    in
    if
        possibleGame { color = "red", cubeVals = justCubeValues, loaded = 12 }
            && possibleGame { color = "green", cubeVals = justCubeValues, loaded = 13 }
            && possibleGame { color = "blue", cubeVals = justCubeValues, loaded = 14 }
    then
        getGameID gameRec

    else
        0


getGameID : String -> Int
getGameID gameRec =
    gameRec
        |> String.split ":"
        |> List.head
        |> Maybe.withDefault ""
        |> String.filter Char.isDigit
        |> String.toInt
        |> Maybe.withDefault 0


possibleGame : { cubeVals : String, color : String, loaded : Int } -> Bool
possibleGame args =
    args.cubeVals
        |> String.split ","
        |> (\l -> getMaximumByColor l args.color)
        |> (\max -> max <= args.loaded)


getMaximumByColor : List String -> String -> Int
getMaximumByColor cubeVals color =
    cubeVals
        |> List.filter (\s -> String.contains color s)
        |> List.map
            (\s ->
                String.filter Char.isDigit s
                    |> String.toInt
                    |> (\maybeInt -> Maybe.withDefault 0 maybeInt)
            )
        |> List.maximum
        |> Maybe.withDefault 0


getSumOfPowerOfMinimalCubeSets : String -> String
getSumOfPowerOfMinimalCubeSets gameRecs =
    gameRecs
        |> String.replace ";" ","
        |> String.lines
        |> List.map
            (\s ->
                String.split ":" s
                    |> List.Extra.last
                    |> Maybe.withDefault ""
                    |> String.split ","
            )
        |> List.map (\ls -> getPower ls)
        |> List.sum
        |> String.fromInt


getPower : List String -> Int
getPower gameRec =
    let
        max =
            [ getMaximumByColor gameRec "red", getMaximumByColor gameRec "green", getMaximumByColor gameRec "blue" ]
    in
    max
        |> List.product
