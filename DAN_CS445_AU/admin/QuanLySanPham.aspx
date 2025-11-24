<%@ Page Title="Quản lý Sản phẩm - MonaFruit Admin" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="DAN_CS445_AU.admin.QuanLySanPham" %>

<%-- Content for the <head> section (ContentPlaceHolderID="head") --%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- Add CSS links, custom styles, and Tailwind config here --%>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <style>
        .material-symbols-outlined {
            font-variation-settings:
            'FILL' 0,
            'wght' 400,
            'GRAD' 0,
            'opsz' 24
        }
    </style>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#13ec13",
                        "background-light": "#f6f8f6",
                        "background-dark": "#102210",
                    },
                    fontFamily: {
                        "display": ["Work Sans", "Noto Sans", "sans-serif"]
                    },
                    borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
                },
            },
        }
    </script>
</asp:Content>

<%-- Main Content for the <body> section (ContentPlaceHolderID="ContentPlaceHolder1") --%>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="w-full">
        <main class="flex-1 flex-col p-6 md:p-10">
            <header class="flex flex-wrap items-center justify-between gap-4 mb-6">
                <h1 class="text-black dark:text-white text-4xl font-black leading-tight tracking-[-0.033em]">Quản lý Sản phẩm</h1>
            </header>
            <div class="bg-white dark:bg-zinc-900 rounded-xl p-4 mb-6 space-y-4">
                <div class="flex flex-col md:flex-row justify-between items-center gap-4">
                    <div class="w-full md:max-w-md">
                        <label class="flex flex-col min-w-40 h-12 w-full">
                            <div class="flex w-full flex-1 items-stretch rounded-lg h-full">
                                <div class="text-gray-500 dark:text-gray-400 flex bg-background-light dark:bg-background-dark items-center justify-center pl-4 rounded-l-lg">
                                    <span class="material-symbols-outlined">search</span>
                                </div>
                                <%-- Đã thêm AutoPostBack và OnTextChanged cho tìm kiếm --%>
                                <asp:TextBox ID="txtSearchProduct" runat="server" OnTextChanged="btnSearch_Click" AutoPostBack="true" CssClass="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-lg text-black dark:text-white focus:outline-0 focus:ring-2 focus:ring-primary/50 border-none bg-background-light dark:bg-background-dark h-full placeholder:text-gray-500 dark:placeholder:text-gray-400 px-4 rounded-l-none pl-2 text-base font-normal leading-normal" placeholder="Tìm kiếm theo tên sản phẩm..."></asp:TextBox>
                            </div>
                        </label>
                    </div>
                    <%-- Đã thêm OnClick cho nút Thêm --%>
                    <asp:Button ID="btnAddProduct" runat="server" OnClick="btnAddProduct_Click" Text="Thêm sản phẩm mới" CssClass="flex-shrink-0 w-full md:w-auto cursor-pointer items-center justify-center overflow-hidden rounded-lg h-12 bg-primary text-black gap-2 text-sm font-bold leading-normal tracking-[0.015em] min-w-0 px-6" />
                </div>
                
                <%-- Filter buttons (giữ nguyên) --%>
                <div class="flex items-center gap-3">
                    <button class="flex h-10 shrink-0 items-center justify-center gap-x-2 rounded-lg bg-background-light dark:bg-background-dark pl-4 pr-2 hover:bg-gray-200 dark:hover:bg-zinc-700">
                        <p class="text-black dark:text-white text-sm font-medium leading-normal">Danh mục</p>
                        <span class="material-symbols-outlined text-black dark:text-white">arrow_drop_down</span>
                    </button>
                    <button class="flex h-10 shrink-0 items-center justify-center gap-x-2 rounded-lg bg-background-light dark:bg-background-dark pl-4 pr-2 hover:bg-gray-200 dark:hover:bg-zinc-700">
                        <p class="text-black dark:text-white text-sm font-medium leading-normal">Trạng thái</p>
                        <span class="material-symbols-outlined text-black dark:text-white">arrow_drop_down</span>
                    </button>
                    <button class="text-sm text-gray-500 dark:text-gray-400 hover:text-black dark:hover:text-white ml-2">Xoá bộ lọc</button>
                </div>
            </div>
            
            <%-- Product Table --%>
            <div class="bg-white dark:bg-zinc-900 rounded-xl overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                        <thead class="text-xs text-gray-700 dark:text-gray-300 uppercase bg-gray-50 dark:bg-zinc-800">
                            <tr>
                                <th class="p-4" scope="col"><input class="form-checkbox rounded border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-zinc-800 text-primary focus:ring-primary/50" type="checkbox"/></th>
                                <th class="px-6 py-3" scope="col">Sản phẩm</th>
                                <th class="px-6 py-3" scope="col">Danh mục</th>
                                <th class="px-6 py-3" scope="col">Giá</th>
                                <th class="px-6 py-3" scope="col">Tồn kho</th>
                                <th class="px-6 py-3" scope="col">Trạng thái</th>
                                <th class="px-6 py-3" scope="col">Hành động</th>
                            </tr>
                        </thead>

                        <%-- KHU VỰC ĐÃ SỬA: BỔ SUNG asp:Repeater --%>
                        <asp:Repeater ID="ProductRepeater" runat="server">
                            <HeaderTemplate>
                                <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr class="bg-white dark:bg-zinc-900 border-b dark:border-zinc-800 hover:bg-gray-50 dark:hover:bg-zinc-800/50">
                                    <td class="w-4 p-4"><input class="form-checkbox rounded border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-zinc-800 text-primary focus:ring-primary/50" type="checkbox"/></td>
                                    <th class="px-6 py-4 font-medium text-gray-900 dark:text-white whitespace-nowrap flex items-center gap-3" scope="row">
                                        <img class="w-10 h-10 rounded-lg object-cover" data-alt="<%# Eval("Name") %>" src="<%# Eval("ImageUrl") %>"/>
                                        <%# Eval("Name") %>
                                    </th>
                                    <td class="px-6 py-4"><%# Eval("Category") %></td>
                                    <td class="px-6 py-4"><%# FormatCurrency(Eval("Price")) %></td>
                                    <td class="px-6 py-4"><%# Eval("StockQuantity") %></td>
                                    <td class="px-6 py-4">
                                        <span class="px-2 py-1 text-xs font-medium rounded-full <%# GetStatusClass(Eval("Status").ToString()) %>"><%# Eval("Status") %></span>
                                    </td>
                                    <td class="px-6 py-4 flex items-center gap-2">
                                        <%-- Nút Sửa (Edit) --%>
                                        <asp:HyperLink runat="server" NavigateUrl='<%# "ProductDetail.aspx?id=" + Eval("ProductID") %>' CssClass="p-2 text-blue-600 dark:text-blue-400 hover:bg-gray-100 dark:hover:bg-zinc-800 rounded-lg">
                                            <span class="material-symbols-outlined text-base">edit</span>
                                        </asp:HyperLink>
                                        
                                        <%-- Nút Xóa (Delete) --%>
                                        <asp:LinkButton ID="LinkButtonDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("ProductID") %>' OnCommand="DeleteProduct" CssClass="p-2 text-red-600 dark:text-red-400 hover:bg-gray-100 dark:hover:bg-zinc-800 rounded-lg" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">
                                            <span class="material-symbols-outlined text-base">delete</span>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                            </FooterTemplate>
                        </asp:Repeater>
                    </table>
                </div>
                
                <%-- Phần Pagination (Giữ nguyên) --%>
                <nav aria-label="Table navigation" class="flex items-center justify-between p-4">
                    <span class="text-sm font-normal text-gray-500 dark:text-gray-400">Showing <span class="font-semibold text-gray-900 dark:text-white">1-5</span> of <span class="font-semibold text-gray-900 dark:text-white">100</span></span>
                    <ul class="inline-flex items-center -space-x-px">
                        <li>...</li>
                    </ul>
                </nav>
            </div>
        </main>
    </div>
</asp:Content>