# DataScienceHWSub StockData()

'For every worksheet
Dim WS As Worksheet

For Each WS In Worksheets

' Set an initial variable for holding the Ticker Letter
  Dim Ticker As String

' Set an initial variable for holding the total number of tickers
  Dim Ticker_Total As Double
  Ticker_Total = 0

' Keep track of the location for each ticker letter in the summary table
  Dim Summary_Table_Row As Integer
  Summary_Table_Row = 2

' Loop through all ticker letters
  For i = 2 To Cells(Rows.Count, 1).End(xlUp).Row

' Check if we are still within the same ticker letter, if it is not...
  If WS.Cells(i + 1, 1).Value <> WS.Cells(i, 1).Value Then

' Set the Ticker Letter
  Ticker = WS.Cells(i, 1).Value

' Add to the Ticker Total
  Ticker_Total = Ticker_Total + WS.Cells(i, 7).Value

' Print the Ticker Letter in the Summary Table
  WS.Range("I" & Summary_Table_Row).Value = Ticker

' Print the Ticker Volume to the Summary Table
  WS.Range("J" & Summary_Table_Row).Value = Ticker_Total

' Add one to the summary table row
  Summary_Table_Row = Summary_Table_Row + 1
      
' Reset the Ticker Total
  Ticker_Total = 0

' If the cell immediately following a row is the same ticker...
  Else

' Add to the Ticker Total
  Ticker_Total = Ticker_Total + WS.Cells(i, 7).Value

End If
Next i
Next WS
End Sub

