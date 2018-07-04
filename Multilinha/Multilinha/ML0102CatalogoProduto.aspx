<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ML0102CatalogoProduto.aspx.cs" Inherits="Multilinha.ML0102CatalogoProduto" %>

<%@ Register Src="~/header.ascx" TagPrefix="uc1" TagName="header" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Catálogo Produto Multilinha</title>
    <meta http-equiv="X-UA-Compatible" content="IE=11" />
    <link href="css/jquery-ui.css" rel="stylesheet" />
    <link href="css/multilinha.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="scripts/jquery-1.12.4.min.js"></script>
    <script src="scripts/jquery-ui.js"></script>
    <script src="scripts/bootstrap.js"></script>
    

</head>
<uc1:header runat="server" ID="header" />
<body class="">
    <form id="form1" class="content container-fluid form-horizontal" runat="server">
        <div id="dvError" runat="server">
            <asp:Label runat="server" ID="lberror" CssClass="col-md-12 col-sm-12 lbl" Visible="false ">Occur an error</asp:Label>
        </div>
        <div class="clear"></div>
        <br />
        <div class="row titleTransaction">
            <asp:Label ID="lblTransaction" runat="server">Parameterização de Multilinha</asp:Label>
        </div>
        <div class="row colorbck">
            <div class="row form-group padding-row ">
                <div class="col-sm-4">
                    <asp:Label ID="lblProduto" runat="server" CssClass="col-sm-4 text-right lbl">* Produto: </asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtProductCode" MaxLength="2" pattern="[A-Za-z0-9]{2}" title="Deve inserir um código alfanumérico com duas posições"
                            oninvalid="setCustomValidity('Deve inserir um código alfanumérico com duas posições')"
                            onchange="try{setCustomValidity('')}catch(e){}" AutoPostBack="true" CssClass="form-control text-field" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" CssClass="bklabel" runat="server" ID="reqProductCode" ControlToValidate="txtProductCode" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-sm-4">
                    <asp:Label ID="lblSubProduto" runat="server" CssClass="col-sm-4 text-right lbl">* Sub-Produto: </asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtSubProdCode" AutoPostBack="true" pattern="[0-9]{2}" title="Deve inserir um número com duas posições"
                            oninvalid="setCustomValidity('Deve inserir um número com duas posições')"
                            onchange="try{setCustomValidity('')}catch(e){}" MaxLength="2" CssClass="form-control text-field" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" CssClass="bklabel" runat="server" ID="reqSubProdCode" ControlToValidate="txtSubProdCode" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-sm-4">
                    <asp:Label ID="lblProdutoDesc" runat="server" CssClass="col-sm-4 text-right lbl"></asp:Label>
                    <div class="col-sm-6">
                        <select id="ddlProdutoDescription" runat="server" class="form-control text-field">
                            <option value="ML Base">ML Base</option>
                            <option value="ML Avançado">ML Avançado</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="row text-right div-btns">
                <a id="btnClearKeys" class="btns btns-alt " runat="server">Limpar</a>
                <button id="btnSearch" class="btns " runat="server">Consultar</button>
                <%--<a id="btnCloseAll" class="btns btns-left " runat="server">Fechar</a>
                <a id="btnOpenAll" class="btns " runat="server">Abrir</a>--%>
            </div>
            <div class="row form-group padding-row ">
                <div class="col-sm-6">
                    <asp:Label ID="lblDtInicio" runat="server" CssClass="col-sm-4 text-right lbl" MaxLength="10">* Data início comercialização: </asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="dpBeginDateTomorrow" placeholder="0001-01-01" MaxLength="10" CssClass="form-control text-field dtField" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" CssClass="bklabel" runat="server" ID="requiredformatdtini" ControlToValidate="dpBeginDateTomorrow" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                        <label class="requiredFieldEmpty" style="display: none;" id="reqBeginDateTomorrow" runat="server">Formato incorreto</label>
                    </div>
                </div>
                <div class="col-sm-6">
                    <asp:Label ID="lblDtFim" runat="server" CssClass="col-sm-4 text-right lbl">* Data fim comercialização:</asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="dpEndDate" placeholder="0001-01-01" CssClass="form-control text-field dtField" MaxLength="10" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" runat="server" ID="reqEndDate" CssClass="bklabel" ControlToValidate="dpEndDate" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                        <label class="requiredFieldEmpty" style="display: none;" id="requiredformatdtfn" runat="server">Formato incorreto</label>
                    </div>
                </div>
            </div>
            <div class="row form-group padding-row ">
                <div class="col-sm-6">
                    <asp:Label ID="lblPrazoMin" runat="server" CssClass="col-sm-4 text-right lbl">* Prazo mínimo (meses):</asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtPrazoMinimo" MaxLength="3" CssClass="form-control text-field" runat="server" onkeypress="return isNumber(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" CssClass="bklabel" runat="server" ID="reqPrazoMinimo" ControlToValidate="txtPrazoMinimo" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-sm-6">
                    <asp:Label ID="lblPrazoMax" runat="server" CssClass="col-sm-4 text-right lbl">* Prazo máximo (meses):</asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtPrazoMaximo" MaxLength="3" CssClass="form-control text-field" runat="server" onkeypress="return isNumber(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" runat="server" ID="reqtxtPrazoMaximo" CssClass="bklabel" ControlToValidate="txtPrazoMaximo" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="row form-group padding-row ">
                <div class="col-sm-6">
                    <asp:Label ID="lblNumProd" runat="server" CssClass="col-sm-4 text-right lbl">* Número mínimo de produtos ativar:</asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtNMinimoProdutosAtivar" MaxLength="2" CssClass="form-control text-field" value="2" runat="server" onkeypress="return isNumber(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" CssClass="bklabel" runat="server" ID="reqNMinimoProdutosAtivar" ControlToValidate="txtPrazoMinimo" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-sm-6">
                </div>
            </div>

            <div class="row form-group padding-row ">
                <div class="col-sm-6">
                    <asp:Label ID="lblLimiteMin" runat="server" CssClass="col-sm-4 text-right lbl">* Limite minimo crédito:</asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtLimMinCredito" CssClass="form-control text-field" MaxLength="18" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" CssClass="bklabel" runat="server" ID="reqLimMinCredito" ControlToValidate="txtLimMinCredito" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-sm-6">
                    <asp:Label ID="lblLimiteMax" runat="server" CssClass="col-sm-4 text-right lbl">* Limite máximo crédito:</asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtLimMaxCredito" CssClass="form-control text-field" MaxLength="18" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" runat="server" ID="reqLimMaxCredito" CssClass="bklabel" ControlToValidate="txtLimMaxCredito" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="row form-group padding-row ">
                <div class="col-sm-6">
                    <asp:Label ID="lblEstadoParam" runat="server" CssClass="col-sm-4 text-right lbl">* Estado da parameterização:</asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtEstadoParameterizacao" Enabled="false" CssClass="form-control text-field" MaxLength="30" value="PENDENTE" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" CssClass="bklabel" runat="server" ID="reqEstadoParameterizacao" ControlToValidate="txtEstadoParameterizacao" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="col-sm-6">
                    <asp:Label ID="lblNumIncum" runat="server" CssClass="col-sm-4 text-right lbl" class="col-sm-4 text-right lbls">* Nº dias incumprimento para inibição:</asp:Label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtNdiasIncumprimento" onkeypress="return isNumber(event)" MaxLength="3" CssClass="form-control text-field" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" runat="server" ID="reqNdiasIncumprimento" CssClass="bklabel" ControlToValidate="txtNdiasIncumprimento" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
        </div>
        <div class="row titleAccordion" onclick="fAccordionController();">
            <a id="titleRenovacao" runat="server" class="accordion " title="Renovação">Renovação</a>
        </div>
        <div id="divRenovacao" runat="server" class="row closeAccordion colorbck hidden ">
            <div class="col-sm-12">
                <div class="row colorbck">
                    <div class="row form-group padding-row">
                        <div class="col-sm-6">
                            <asp:Label ID="lblIndicadorRenova" runat="server" CssClass="col-sm-4 text-right lbl">* Indicador de renovação:</asp:Label>
                            <div class="col-sm-6">
                                <asp:DropDownList ID="ddlIndicadorRenovacao" OnTextChanged="ddlIndicadorRenovacao_TextChanged" runat="server" CssClass="form-control text-field">
                                    <asp:ListItem Value="S" Text="Sim"></asp:ListItem>
                                    <asp:ListItem Value=" " Text="Não"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <asp:Label ID="lblPrazoRenova" runat="server" CssClass="col-sm-4 text-right lbl">Prazo renovação (meses):</asp:Label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txtPrazoRenovacao" onkeypress="return isNumber(event)" runat="server" CssClass="form-control text-field"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" CssClass="bklabel" runat="server" ID="reqPrazoRenovacao" ControlToValidate="txtPrazoRenovacao" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row titleAccordion" onclick="fAccordionController();">
            <a id="titleRiscoFinanceiro" runat="server" class="accordion " title="Risco Financeiro">Risco Financeiro</a>
        </div>
        <div id="divRiscoFinanceiro" runat="server" class="row closeAccordion colorbck hidden ">
            <div class="col-sm-12">
                <div class="row form-group padding-row">
                    <div class="col-sm-6">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-6">
                            <asp:TreeView runat="server" ID="trtipologiaProdutosRFTree" CssClass="treViewCatalogo"></asp:TreeView>
                        </div>
                    </div>
                    <div class="col-sm-6">
                    </div>
                </div>
            </div>
        </div>

        <div class="row titleAccordion" onclick="fAccordionController();">
            <a id="titleRiscoAssinatura" runat="server" class="accordion " title="Risco Assinatura">Risco Assinatura</a>
        </div>
        <div id="divRiscoAssinatura" runat="server" class="row closeAccordion colorbck hidden ">
            <div class="col-sm-12">
                <div class="row form-group padding-row">
                    <div class="col-sm-6">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-6">
                            <asp:TreeView runat="server" ID="trtipologiaProdutosRATree" CssClass="treViewCatalogo"></asp:TreeView>
                        </div>
                    </div>
                    <div class="col-sm-6">
                    </div>
                </div>
            </div>
        </div>

        <div class="row titleAccordion" onclick="fAccordionController();">
            <a id="titleRiscoComercial" runat="server" class="accordion " title="Risco Comercial">Risco Comercial</a>
        </div>
        <div id="divRiscoComercial" runat="server" class="row closeAccordion colorbck hidden ">
            <div class="col-sm-12">
                <div class="row form-group padding-row">
                    <div class="col-sm-4"></div>
                    <div class="col-sm-6">
                        <asp:TreeView runat="server" ID="trtipologiaProdutosRCTree" CssClass="treViewCatalogo"></asp:TreeView>
                    </div>
                    <div class="col-sm-6">
                    </div>
                </div>
            </div>
        </div>
        <br />
        <div class="row ">
            <div class="col-sm-6">
                <label class="col-sm-6 text-right lbl">* Periocidade de cobrança comissão de gestão (meses):</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="txtPeriocidadeCobranca" MaxLength="3" value="1" CssClass="form-control text-field" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator Display="Dynamic" CssClass="bklabel" runat="server" ID="reqPeriocidadeCobranca" ControlToValidate="txtPeriocidadeCobranca" ForeColor="Red" ErrorMessage="Campo Obrigatório"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>

        <hr class="hr" />

        <div class="row text-right div-btns">
            <button id="btnCreate" class="btns " runat="server">Criar</button>
            <button id="btnEdit" class="btns " runat="server">Modificar</button>
            <button id="btnSave" class="btns" runat="server">Guardar</button>
            <button id="btnCancel" class="btns" runat="server">Anular</button>
        </div>

         <hr class="hr" />

        <div id="filtrospesquisa" runat="server" class="row">
            <div class="Table">
                <div class="Row">
                    <div class="CellNoBorder">
                        <h4>Linqs úteis</h4>
                        <ul>
                            <li>
                                <a href="#">Comissão de abertura</a>
                            </li>
                            <li>
                                <a href="#">Comissão de renovação</a>
                            </li>
                            <li>
                                <a href="#">Comissão de gestão de contrato</a>
                            </li>
                            <li>
                                <a href="#">Comissão de novação</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <br />
    </form>

    <script type='text/javascript'>
        var dtfechas = "<%=this.dtfechas %>";
        $('#dpEndDate').datepicker('setDate', '9999-12-31');

    </script>
    <script src="scripts/multilinha.js"></script>
</body>
</html>
