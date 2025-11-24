<%@ Page Title="Quản lý Sản phẩm - MonaFruit Admin" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="DAN_CS445_AU.admin.QuanLySanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <style>
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24 }
    </style>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: { "primary": "#13ec13", "background-light": "#f6f8f6", "background-dark": "#102210" },
                    fontFamily: { "display": ["Work Sans", "Noto Sans", "sans-serif"] },
                },
            },
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="w-full">
        <header class="flex flex-wrap items-center justify-between gap-4 mb-6">
            <h1 class="text-black dark:text-white text-4xl font-black leading-tight tracking-[-0.033em]">Quản lý Sản phẩm</h1>
        </header>

        <div class="bg-white dark:bg-zinc-900 rounded-xl p-4 mb-6 space-y-4 shadow-sm">
            <div class="flex flex-col md:flex-row justify-between items-center gap-4">
                <div class="w-full md:max-w-md">
                    <label class="flex flex-col min-w-40 h-12 w-full">
                        <div class="flex w-full flex-1 items-stretch rounded-lg h-full border border-gray-200 dark:border-zinc-700 overflow-hidden">
                            <div class="text-gray-500 dark:text-gray-400 flex bg-background-light dark:bg-background-dark items-center justify-center pl-4">
                                <span class="material-symbols-outlined">search</span>
                            </div>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden text-black dark:text-white focus:outline-0 focus:ring-2 focus:ring-primary/50 border-none bg-background-light dark:bg-background-dark h-full px-4 pl-2" placeholder="Tìm kiếm..."></asp:TextBox>
                        </div>
                    </label>
                </div>
                <a href="ThemSanPham.aspx" class="flex-shrink-0 w-full md:w-auto cursor-pointer flex items-center justify-center overflow-hidden rounded-lg h-12 bg-primary text-black gap-2 text-sm font-bold px-6 hover:brightness-90 transition-all no-underline">
                    <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1">add</span>
                    <span class="truncate">Thêm sản phẩm mới</span>
                </a>
            </div>
            
            <div class="flex items-center gap-3 overflow-x-auto pb-2 md:pb-0">
               </div>
        </div>

        <div class="bg-white dark:bg-zinc-900 rounded-xl overflow-hidden shadow-sm border border-gray-100 dark:border-zinc-800">
            <div class="overflow-x-auto">
                <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                    <thead class="text-xs text-gray-700 dark:text-gray-300 uppercase bg-gray-50 dark:bg-zinc-800">
                        <tr>
                            <th class="p-4"><input class="form-checkbox rounded text-primary focus:ring-primary/50" type="checkbox" /></th>
                            <th class="px-6 py-3">Sản phẩm</th>
                            <th class="px-6 py-3">Danh mục</th>
                            <th class="px-6 py-3">Giá</th>
                            <th class="px-6 py-3">Tồn kho</th>
                            <th class="px-6 py-3">Trạng thái</th>
                            <th class="px-6 py-3">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                            <ItemTemplate>
                                <tr class="bg-white dark:bg-zinc-900 border-b dark:border-zinc-800 hover:bg-gray-50 dark:hover:bg-zinc-800/50 transition-colors">
                                    <td class="w-4 p-4">
                                        <input class="form-checkbox rounded text-primary focus:ring-primary/50" type="checkbox" />
                                    </td>
                                    
                                    <th class="px-6 py-4 font-medium text-gray-900 dark:text-white whitespace-nowrap flex items-center gap-3">
                                        <img class="w-10 h-10 rounded-lg object-cover" alt='<%# Eval("TieuDe") %>' 
                                             src='<%# string.IsNullOrEmpty(Eval("HinhAnh").ToString()) ? "https://via.placeholder.com/150" : Eval("HinhAnh") %>' />
                                        <%# Eval("TieuDe") %>
                                    </th>

                                    <td class="px-6 py-4"><%# Eval("TenDanhMuc") %></td>

                                    <td class="px-6 py-4"><%# Eval("Gia", "{0:N0}₫") %></td>

                                    <td class="px-6 py-4">
                                        <span class='<%# Convert.ToInt32(Eval("SoLuong")) == 0 ? "text-red-500 font-bold" : "" %>'>
                                            <%# Eval("SoLuong") %>
                                        </span>
                                    </td>

                                    <td class="px-6 py-4">
                                        <span class='px-2 py-1 text-xs font-medium rounded-full 
                                            <%# Convert.ToInt32(Eval("SoLuong")) > 0 ? "bg-green-100 text-green-800" : "bg-gray-100 text-gray-800" %>'>
                                            <%# Convert.ToInt32(Eval("SoLuong")) > 0 ? "Đang bán" : "Hết hàng" %>
                                        </span>
                                    </td>

                                    <td class="px-6 py-4 flex items-center gap-2">
                                        <a href='ThemSanPham.aspx?id=<%# Eval("sp_id") %>' class="p-2 text-blue-600 hover:bg-gray-100 rounded-lg">
                                            <span class="material-symbols-outlined text-base">edit</span>
                                        </a>

                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("sp_id") %>'
                                            OnClientClick="return confirm('Bạn có chắc chắn muốn xóa?');"
                                            CssClass="p-2 text-red-600 hover:bg-gray-100 rounded-lg">
                                            <span class="material-symbols-outlined text-base">delete</span>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        </tbody>
                </table>
            </div>

            <nav class="flex flex-col md:flex-row items-center justify-between p-4 border-t border-gray-100 dark:border-zinc-800 gap-4">
                <span class="text-sm font-normal text-gray-500">Hiển thị <span class="font-semibold text-gray-900">1-5</span> trong số <span class="font-semibold text-gray-900">100</span></span>
                </nav>
        </div>
    </div>
</asp:Content>