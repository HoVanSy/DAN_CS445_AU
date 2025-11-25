<%@ Page Title="Quản lý Đơn hàng" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="DAN_CS445_AU.admin.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    
    <style>
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
    </style>

    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#4CAF50",
                        "background-light": "#F8F9FA",
                        "background-dark": "#1a1a1a",
                        "card-light": "#FFFFFF",
                        "card-dark": "#242424",
                        "border-light": "#DEE2E6",
                        "border-dark": "#333333",
                        "text-light": "#212529",
                        "text-dark": "#e5e5e5",
                        // Màu trạng thái
                        "success": "#28A745",
                        "warning": "#FFC107",
                        "info": "#007BFF",
                        "danger": "#DC3545",
                    },
                    fontFamily: { "display": ["Work Sans", "sans-serif"] },
                },
            },
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="layout-content-container mx-auto flex max-w-7xl flex-col flex-1">
        
        <div class="flex flex-wrap items-center justify-between gap-4 mb-6">
            <h1 class="text-3xl md:text-4xl font-black tracking-tight text-text-light dark:text-text-dark">Quản lý Đơn hàng</h1>
        </div>

        <div class="mb-6 p-4 bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark rounded-lg shadow-sm">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                <div class="lg:col-span-2">
                    <label class="flex flex-col min-w-40 h-11 w-full">
                        <div class="flex w-full flex-1 items-stretch rounded-lg h-full bg-background-light dark:bg-background-dark border border-border-light dark:border-border-dark focus-within:ring-2 focus-within:ring-primary/50">
                            <div class="text-gray-500 dark:text-gray-400 flex items-center justify-center pl-3">
                                <span class="material-symbols-outlined">search</span>
                            </div>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden text-text-light dark:text-text-dark focus:outline-0 focus:ring-0 border-none bg-transparent h-full placeholder:text-gray-500 dark:placeholder:text-gray-400 pl-2 text-base font-normal" placeholder="Tìm kiếm mã đơn, tên khách..."></asp:TextBox>
                        </div>
                    </label>
                </div>
                <div>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="w-full h-11 rounded-lg border border-border-light dark:border-border-dark bg-background-light dark:bg-background-dark text-text-light dark:text-text-dark focus:border-primary focus:ring-primary/50 text-base">
                        <asp:ListItem Value="">Tất cả trạng thái</asp:ListItem>
                        <asp:ListItem>Chờ xác nhận</asp:ListItem>
                        <asp:ListItem>Đã xác nhận</asp:ListItem>
                        <asp:ListItem>Đang giao</asp:ListItem>
                        <asp:ListItem>Đã giao</asp:ListItem>
                        <asp:ListItem>Đã hủy</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div>
                    <input type="date" class="w-full h-11 rounded-lg border border-border-light dark:border-border-dark bg-background-light dark:bg-background-dark text-text-light dark:text-text-dark focus:border-primary focus:ring-primary/50 text-base" />
                </div>
            </div>
            <div class="mt-4 flex justify-end">
                <asp:Button ID="btnFilter" runat="server" Text="Lọc dữ liệu" OnClick="btnFilter_Click" CssClass="bg-primary text-white font-bold py-2 px-6 rounded-lg hover:brightness-110 cursor-pointer" />
            </div>
        </div>

        <div class="overflow-x-auto @container bg-card-light dark:bg-card-dark border border-border-light dark:border-border-dark rounded-lg shadow-sm">
            <table class="min-w-full divide-y divide-border-light dark:divide-border-dark">
                <thead class="bg-background-light dark:bg-background-dark">
                    <tr>
                        <th class="w-12 px-6 py-3 text-center"><input class="h-4 w-4 rounded border-gray-300 dark:border-gray-600 text-primary focus:ring-primary/50 bg-card-light dark:bg-card-dark" type="checkbox"/></th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Mã Đơn</th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Khách hàng</th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Ngày đặt</th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Tổng tiền</th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Trạng thái</th>
                        <th class="px-6 py-3 text-left text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider">TT Thanh toán</th>
                        <th class="px-6 py-3 text-center text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider">Hành động</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-border-light dark:divide-border-dark">
                    
                    <asp:Repeater ID="rptDonHang" runat="server">
                        <ItemTemplate>
                            <tr class="hover:bg-gray-50 dark:hover:bg-zinc-800/50 transition-colors">
                                <td class="px-6 py-4 whitespace-nowrap text-center">
                                    <input class="h-4 w-4 rounded border-gray-300 dark:border-gray-600 text-primary focus:ring-primary/50 bg-card-light dark:bg-card-dark" type="checkbox"/>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-text-light dark:text-text-dark">
                                    #MNF-<%# Eval("Dh_id") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                    <%# Eval("HoVaTen") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                    <%# Eval("NgayDat", "{0:dd/MM/yyyy}") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <%# string.Format("{0:N0}đ", Eval("TongTien")) %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <%# GetStatusHtml(Eval("TrangThai").ToString()) %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                    <%# Eval("PhuongThucTT") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-center">
                                    <button type="button" class="p-2 text-gray-500 hover:text-primary dark:hover:text-primary transition-colors" title="Xem chi tiết"><span class="material-symbols-outlined text-xl">visibility</span></button>
                                    <button type="button" class="p-2 text-gray-500 hover:text-info dark:hover:text-info transition-colors" title="Cập nhật"><span class="material-symbols-outlined text-xl">update</span></button>
                                    <button type="button" class="p-2 text-gray-500 hover:text-red-500 transition-colors" title="Hủy đơn"><span class="material-symbols-outlined text-xl">cancel</span></button>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>

                </tbody>
            </table>
            
            <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="p-8 text-center text-gray-500">
                Không tìm thấy đơn hàng nào.
            </asp:Panel>
        </div>

        <div class="mt-6 flex items-center justify-between">
            <p class="text-sm text-gray-600 dark:text-gray-400">
                Hiển thị <span class="font-bold">1</span>-<span class="font-bold">5</span> trên <span class="font-bold">50</span> kết quả
            </p>
            <div class="flex items-center gap-2">
                <button class="flex items-center justify-center h-9 w-9 rounded border border-border-light dark:border-border-dark bg-card-light dark:bg-card-dark hover:bg-background-light dark:hover:bg-background-dark disabled:opacity-50">
                    <span class="material-symbols-outlined text-xl">chevron_left</span>
                </button>
                <button class="flex items-center justify-center h-9 w-9 rounded border border-primary bg-primary text-white text-sm font-bold">1</button>
                <button class="flex items-center justify-center h-9 w-9 rounded border border-border-light dark:border-border-dark bg-card-light dark:bg-card-dark hover:bg-background-light dark:hover:bg-background-dark text-sm">2</button>
                <button class="flex items-center justify-center h-9 w-9 rounded border border-border-light dark:border-border-dark bg-card-light dark:bg-card-dark hover:bg-background-light dark:hover:bg-background-dark">
                    <span class="material-symbols-outlined text-xl">chevron_right</span>
                </button>
            </div>
        </div>

    </div>
</asp:Content>