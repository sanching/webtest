<%@ Page EnableEventValidation="false" Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:Label ID="LabelTxt" runat="server" Text="Label"></asp:Label>

            <br />
            請選擇磁碟機:<br />
            <asp:RadioButtonList ID="RadioButtonDisk" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="C">C槽 </asp:ListItem>
                <asp:ListItem Value="D" Selected="True">D槽</asp:ListItem>
            </asp:RadioButtonList>

            <br />
            檔案目錄:<br />
            <asp:TextBox ID="TextBoxFilePath" runat="server"></asp:TextBox>
            &nbsp;(例如: inetpub\erp)<br />

            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="確定" />
            &nbsp;
            <asp:Button ID="ImageButtonExportExcelTop" runat="server" Text="轉出明細(Excel)"
                OnClick="ImageButtonExportExcelTop_Click" />
            <br />
            <br />
            <br />

            <asp:GridView ID="GridViewFiles" runat="server" AutoGenerateColumns="false" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
                BorderWidth="1px" CellPadding="3">
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
                <Columns>
                    <asp:TemplateField HeaderText="磁碟槽">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("FileDisk") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="檔案名稱">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Name") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="檔案路徑">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("FullPath") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="容量(Byte)">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Size") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <br />
        </div>
    </form>
</body>
</html>
