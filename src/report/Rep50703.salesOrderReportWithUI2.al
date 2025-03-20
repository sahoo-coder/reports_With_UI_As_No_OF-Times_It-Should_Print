report 50703 "salesOrderReportWithUI_2"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './salesOrderReportWithInteger_UI_2.rdl';
    Caption = 'Sales Order Report With Integer_UI_2_KSS';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                dataitem(Integer; Integer)
                {
                    column(Number; Number) { }
                    column(Order_No_; "Sales Header"."No.") { }
                    column(Customer_Name; "Sales Header"."Sell-to Customer Name") { }
                    column(Order_Date; "Sales Header"."Order Date") { }
                    column(Posting_Date; "Sales Header"."Posting Date") { }
                    column(Salesperson_Code; "Sales Header"."Salesperson Code") { }

                    column(Item_No_; "Sales Line"."No.") { }
                    column(Description; "Sales Line".Description) { }
                    column(Quantity_Ordered; "Sales Line".Quantity) { }
                    column(Unit_Price; "Sales Line"."Unit Price") { }
                    column(Amount_Including_VAT; "Sales Line"."Amount Including VAT") { }

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
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if orderNumber <> '' then begin
                    "Sales Header".SetRange("No.", orderNumber);
                end;
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