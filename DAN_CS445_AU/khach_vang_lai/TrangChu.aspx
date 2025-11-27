<%@ Page Title="Trang Chủ" Language="C#" MasterPageFile="Header.master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="DAN_CS445_AU.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div id="sanpham" class="max-w-screen-xl mx-auto px-4 py-8">
        <h2 class="text-3xl font-bold text-heading-light dark:text-heading-dark mb-8 border-l-4 border-primary pl-4">Sản Phẩm Mới</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <asp:Repeater ID="rptSanPham" runat="server">
                <ItemTemplate>
                    <div class="bg-white dark:bg-surface-dark rounded-xl shadow-sm p-4 border border-gray-100 hover:shadow-lg transition">
                        <img src='<%# Eval("HinhAnh") %>' class="w-full h-48 object-cover mb-4 rounded" />
                        <h3 class="font-bold text-lg mb-2 text-heading-light dark:text-heading-dark"><%# Eval("TieuDe") %></h3>
                        <p class="text-sm text-gray-500 mb-2"><%# Eval("TenNongTrai") %></p>
                        <div class="flex justify-between items-center">
                            <span class="text-primary font-bold text-xl"><%# Eval("Gia", "{0:N0} đ") %></span>
                            <button class="bg-primary text-white px-3 py-1 rounded hover:bg-opacity-80">Mua</button>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <div class="bg-green-50 dark:bg-gray-900 py-12">
        <div class="max-w-screen-xl mx-auto px-4">
            <h2 class="text-3xl font-bold text-heading-light dark:text-heading-dark mb-8 text-center">Sản Phẩm Bán Chạy</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
                <asp:Repeater ID="rptSanPhamBanChay" runat="server">
                    <ItemTemplate>
                        <div class="bg-white dark:bg-surface-dark rounded-xl shadow-md p-4 relative hover:-translate-y-1 transition duration-300">
                            <div class="absolute top-0 left-0 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded-br-lg z-10">HOT</div>
                            <img src='<%# Eval("HinhAnh") %>' class="w-full h-48 object-contain mb-4" />
                            <h3 class="font-bold text-center mb-2 text-heading-light dark:text-heading-dark"><%# Eval("TieuDe") %></h3>
                            <div class="text-center text-primary font-bold"><%# Eval("Gia", "{0:N0} đ") %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>

</asp:Content>