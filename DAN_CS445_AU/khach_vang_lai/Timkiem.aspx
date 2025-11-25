<%@ Page Title="Kết quả tìm kiếm" Language="C#" MasterPageFile="Header.master" AutoEventWireup="true" CodeBehind="Timkiem.aspx.cs" Inherits="DAN_CS445_AU.Timkiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <nav class="py-4 flex items-center justify-between container mx-auto px-4">
        <div class="w-1/4">
            <button class="bg-primary text-white font-bold py-3 px-6 rounded-md flex items-center gap-3 w-full justify-center">
                <span class="material-icons-outlined">menu</span>DANH MỤC SẢN PHẨM
            </button>
        </div>
        <div class="hidden lg:flex items-center gap-8 text-heading-light dark:text-heading-dark font-semibold">
            <a class="hover:text-primary transition" href="TrangChu.aspx">Trang chủ</a>
            <a class="hover:text-primary transition" href="GioiThieu.aspx">Giới thiệu</a>
            <a class="hover:text-primary transition" href="TrangChu.aspx">Sản phẩm</a>
            <a class="hover:text-primary transition" href="TinTuc.aspx">Tin tức</a>
            <a class="hover:text-primary transition" href="LienHe.aspx">Liên hệ</a>
        </div>
    </nav>

    <div class="container mx-auto px-4 py-8">
        
        <div class="mb-8 border-b border-gray-200 pb-4">
            <h1 class="text-3xl font-bold text-heading-light dark:text-heading-dark mb-2">
                Kết quả tìm kiếm cho: 
                <asp:Label ID="lblTuKhoa" runat="server" CssClass="text-primary italic"></asp:Label>
            </h1>
            <p class="text-text-light dark:text-text-dark">
                Tìm thấy 
                <asp:Label ID="lblSoLuong" runat="server" Text="0" Font-Bold="true"></asp:Label> 
                sản phẩm phù hợp.
            </p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <asp:Repeater ID="rptKetQuaTimKiem" runat="server">
                <ItemTemplate>
                    <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-4 shadow-sm hover:shadow-lg transition-shadow border border-gray-100 dark:border-gray-700 flex flex-col h-full">
                        <div class="relative aspect-square mb-4 overflow-hidden rounded-md group">
                            <img src='<%# Eval("HinhAnh") %>' alt='<%# Eval("TenSP") %>' class="object-cover w-full h-full group-hover:scale-110 transition-transform duration-300" />
                        </div>
                        <div class="flex-1 flex flex-col">
                            <h3 class="font-bold text-lg text-heading-light dark:text-heading-dark mb-1 line-clamp-2">
                                <%# Eval("TenSP") %>
                            </h3>
                            <p class="text-sm text-gray-500 mb-3">
                                <span class="material-icons-outlined text-xs align-middle">storefront</span>
                                <%# Eval("TenNongTrai") %>
                            </p>
                            <div class="mt-auto flex justify-between items-center">
                                <span class="text-primary font-bold text-xl">
                                    <%# Eval("Giá", "{0:N0} đ") %>
                                </span>
                                <a href='<%# "ChiTietSanPham.aspx?id=" + Eval("sp_id") %>' class="bg-primary text-white text-sm px-4 py-2 rounded-full hover:opacity-90 font-semibold transition-colors">
                                    Mua ngay
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:Panel ID="pnlKhongTimThay" runat="server" Visible="false" CssClass="flex flex-col items-center justify-center py-16 text-center">
            <span class="material-icons-outlined text-6xl text-gray-300 mb-4">search_off</span>
            <h3 class="text-xl font-bold text-heading-light dark:text-heading-dark mb-2">Không tìm thấy sản phẩm nào</h3>
            <a href="/" class="bg-primary text-white font-bold py-2 px-6 rounded-full hover:opacity-90 mt-4">Về trang chủ</a>
        </asp:Panel>

    </div>

    <section class="grid grid-cols-1 lg:grid-cols-3 gap-6 my-6 container mx-auto px-4">
        <div class="lg:col-span-2 bg-surface-light dark:bg-surface-dark rounded-lg p-8 md:p-12 flex items-center bg-no-repeat bg-left-bottom" style="background-image: url('https://fruitio.monamedia.net/wp-content/uploads/2024/04/organic2-slider1.jpg');">
            <div>
                <p class="text-primary font-bold text-lg">Fresh & Organic</p>
                <h1 class="text-4xl md:text-6xl font-bold text-heading-light dark:text-heading-dark mt-2 mb-4 leading-tight">Nông sản sạch</h1>
                <a class="bg-primary text-white font-bold py-3 px-8 rounded-full hover:opacity-90 transition-opacity" href="#">Khám phá ngay</a>
            </div>
        </div>
        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-8 flex flex-col justify-center items-center text-center bg-no-repeat bg-bottom" style="background-image: url('https://fruitio.monamedia.net/wp-content/uploads/2024/04/organic22-banner-1.jpg'); background-size: contain;">
            <h2 class="text-3xl font-bold text-heading-light dark:text-heading-dark">30% SALE OFF</h2>
            <p class="text-text-light dark:text-text-dark mt-2 mb-4">Ưu đãi mùa hè</p>
        </div>
    </section>

</asp:Content>