report 50700 salesOrderReportWithUserInput
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './salesOrderReportWithInteger_UI.rdl';
    Caption = 'Sales Order Report With Integer_UI_KSS';

    dataset
    {
        dataitem(Integer; Integer)
        {
            column(Number; Number) { }
            dataitem("Sales Header"; "Sales Header")
            {

                column(Order_No_; "No.") { }
                column(Customer_Name; "Sell-to Customer Name") { }
                column(Order_Date; "Order Date") { }
                column(Posting_Date; "Posting Date") { }
                column(Salesperson_Code; "Salesperson Code") { }

                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                    column(Item_No_; "No.") { }
                    column(Description; Description) { }
                    column(Quantity_Ordered; Quantity) { }
                    column(Unit_Price; "Unit Price") { }
                    column(Amount_Including_VAT; "Amount Including VAT") { }
                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    if orderNumber <> '' then begin
                        "Sales Header".SetRange("No.", orderNumber);
                    end;
                end;

            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if totalNo <> 0 then begin
                    SetFilter(Number, '%1..%2', 1, totalNo);
                end
                else
                    Error('Give Number of report to print');

            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group("Sales Order Number_KSS")
                {
                    field(orderNumber; orderNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Order Number_KSS';
                        TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
                    }

                    field(totalNo; totalNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Total Number: ';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }
    var
        orderNumber: Code[50];
        totalNo: Integer;
}