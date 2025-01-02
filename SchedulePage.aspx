<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="SchedulePage.aspx.cs" Inherits="Admin_SchedulePage" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" runat="Server">
    <TheoremWC:ToolBar ID="toolBar" runat="server" PageTitle="Schema Convert">
        <asp:UpdatePanel ID="update1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table width="98%" style="margin: 0px;" border="0">
                    <tr class="btn">
                        <td align="left">
                            <asp:LinkButton ID="btnPaymentDetails" OnClick="btnSchedule_Click" ValidationGroup="Report"  
                                runat="server" Text="Submit" 
                                Style="vertical-align: middle; padding: 10px 20px; color: white; background-color: #007BFF; border: none; border-radius: 4px; cursor: pointer;">
                            </asp:LinkButton>  
                            <Triggers>
                                <asp:PostBackTrigger ControlID="btnPaymentDetails" />
                            </Triggers>
                        </td>
                <asp:Label ID="lblDatasetContent" runat="server" Visible="false" />
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </TheoremWC:ToolBar>

    <TheoremWC:PageContent ID="PageContent1" runat="server">
        <table width="100%">
            <tr>
                <td width="16%" align="left">
                    <b>Academic Year</b>
                    <asp:DropDownList ID="ddlAcademicYear" runat="server" DataValueField="Id" DataTextField="Year"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlAcademicYear_OnSelectedIndexChanged" Width="56%" 
                        Style="padding: 8px; font-size: 14px; border-radius: 4px; border: 1px solid #ccc; margin-bottom: 20px">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvAcademicYear" runat="server" 
                        ControlToValidate="ddlAcademicYear" InitialValue="-1" 
                        ErrorMessage="required." ForeColor="Red" ValidationGroup="Report" />
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="startdate" 
                        ErrorMessage="year is required." ForeColor="Red" ValidationGroup="Report" />
                 </td>
                <td>
                    <b>Module</b>
                    <asp:DropDownList ID="ddlmodule" runat="server" DataTextField="Name" DataValueField="Id" Width="56%" 
                        Style="padding: 8px; font-size: 14px; border-radius: 4px; border: 1px solid #ccc; margin-bottom: 20px">
                        <asp:ListItem Text="--Select--" Value="-1"></asp:ListItem>
                        <asp:ListItem Text="New college" Value="15"></asp:ListItem>
                        <asp:ListItem Text="College Affiliation" Value="13"></asp:ListItem>
                        <asp:ListItem Text="Student Registration" Value="7"></asp:ListItem>
                        <asp:ListItem Text="CounsellingAdmission" Value="10"></asp:ListItem>
                        <asp:ListItem Text="CounsellingSeatSellection" Value="16"></asp:ListItem>
                        <asp:ListItem Text="IA Marks Entry" Value="8"></asp:ListItem>
                        <asp:ListItem Text="Practical Marks Entry" Value="9"></asp:ListItem>
                         <asp:ListItem Text="Questionpaperdownload" Value="19"></asp:ListItem>
                         <asp:ListItem Text="Examination Fees" Value="1"></asp:ListItem>
                         <asp:ListItem Text="Revaluation Applied" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Counseling" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvModule" runat="server" 
                        ControlToValidate="ddlmodule" InitialValue="-1" 
                        ErrorMessage="required" ForeColor="Red" ValidationGroup="Report" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>Start Schedule Date</b>
                    <asp:TextBox ID="startdate" onblur="OnBlur(this);" onfocus="OnFocus(this);"
                        Font-Size="Medium" Width="39%" runat="server" placeholder="--ALL--" 
                        Style="padding: 8px; font-size: 14px; border-radius: 4px; border: 1px solid #ccc;">
                    </asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="cePaymentDate" runat="server" TargetControlID="startdate"
                        EnabledOnClient="true" Format="yyyy/MM/dd" />
                    <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
                        TargetControlID="startdate" FilterType="Numbers, Custom" ValidChars="/" />
                    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" 
                        ControlToValidate="startdate" 
                        ErrorMessage="required" ForeColor="Red" ValidationGroup="Report" />
                    <asp:RegularExpressionValidator ID="revStartDate" runat="server"
                        ControlToValidate="startdate" ValidationExpression="^\d{4}/\d{2}/\d{2}$"
                        ErrorMessage="Invalid date format. Please use yyyy/mm/dd." ForeColor="Red" ValidationGroup="Report" />
                </td>
                <td>
                    <b>End Schedule Without Fine</b>
                    <asp:TextBox ID="withoutfinedate" onblur="OnBlur(this);" onfocus="OnFocus(this);"
                        Font-Size="Small" Width="39%" runat="server" placeholder="--ALL--" 
                        Style="padding: 8px; font-size: 14px; border-radius: 4px; border: 1px solid #ccc;">
                    </asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="withoutfinedate"
                        EnabledOnClient="true" Format="yyyy/MM/dd" />
                    <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server"
                        TargetControlID="withoutfinedate" FilterType="Numbers, Custom" ValidChars="/" />
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="startdate" 
                        ErrorMessage="required." ForeColor="Red" ValidationGroup="Report" />
                 
                    <asp:RegularExpressionValidator ID="revWithoutFine" runat="server" 
                        ControlToValidate="withoutfinedate" ValidationExpression="^\d{4}/\d{2}/\d{2}$"
                        ErrorMessage="Invalid date format. Please use yyyy/mm/dd." ForeColor="Red" ValidationGroup="Report" />
                </td>
                <td>
                    <b>End Schedule With Fine</b>
                    <asp:TextBox ID="Finedate" onblur="OnBlur(this);" onfocus="OnFocus(this);"
                        Font-Size="Small" Width="39%" runat="server" placeholder="--ALL--" 
                        Style="padding: 8px; font-size: 14px; border-radius: 4px; border: 1px solid #ccc;">
                    </asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="Finedate"
                        EnabledOnClient="true" Format="yyyy/MM/dd" />
                    <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server"
                        TargetControlID="Finedate" FilterType="Numbers, Custom" ValidChars="/" />  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="startdate" 
                        ErrorMessage="required" ForeColor="Red" ValidationGroup="Report" />
                 
                    <asp:RegularExpressionValidator ID="revFineDate" runat="server" 
                        ControlToValidate="Finedate" ValidationExpression="^\d{4}/\d{2}/\d{2}$"
                        ErrorMessage="Invalid date format. Please use yyyy/mm/dd." ForeColor="Red" ValidationGroup="Report" />
                </td>
            </tr>
        </table>
    </TheoremWC:PageContent>
</asp:Content>
