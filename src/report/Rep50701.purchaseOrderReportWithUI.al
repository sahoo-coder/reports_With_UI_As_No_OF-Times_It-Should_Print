report 50701 purchaseOrderReportWithUI
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './purchaseOrderReportWithUI.rdl';
    Caption = 'Purchase Order With UI_KSS';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                dataitem(Integer; Integer)
                {
                    column(Number; Number) { }
                    column(Vendor_No_; "Purchase Header"."Buy-from Vendor No.") { }
                    column(Vendor_Name; "Purchase Header"."Buy-from Vendor Name") { }
                    column(Contact_No_; "Purchase Header"."Buy-from Contact No.") { }
                    column(Item_No_; "Purchase Line"."No.") { }
                    column(Quantity; "Purchase Line".Quantity) { }
                    column(Unit_Cost; "Purchase Line"."Unit Cost") { }

                    trigger OnPreDataItem()
                    var
                        myInt: Integer;
                    begin
                        if totalNumber <> 0 then begin
                            SetFilter(Number, '%1..%2', 1, totalNumber);
                        end
                        else
                            Error('Give Total Number of Reports to be printed');
                    end;
                }
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if orderNo <> '' then begin
                    "Purchase Header".SetRange("No.", orderNo);
                end
                else
                    Error('Please Give Order Number');
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
                group("Purchase Order_KSS")
                {
                    field(orderNo; orderNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase Order No';
                        TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
                    }

                    field(totalNumber; totalNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Total No of Reports to be Printed';
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
        totalNumber: Integer;
        orderNo: Code[50];

}