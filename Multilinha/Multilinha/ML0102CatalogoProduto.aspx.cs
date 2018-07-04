using MultilinhasObjects;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Multilinha
{
    public partial class ML0102CatalogoProduto : System.Web.UI.Page
    {
        public DateTime dtfechas = Global.dtfechasG;
        MultilinhasDataLayer.boMultilinhas TAT2 = new MultilinhasDataLayer.boMultilinhas();

        protected void Page_Load(object sender, EventArgs e)
        {
            ABUtil.ABCommandArgs abargs = Session["ABCommandArgs"] as ABUtil.ABCommandArgs;
            DataTable dtProdutos = TAT2.GetProdutos(Global.ConnectionStringDTAB, abargs);



            
            if (!Page.IsPostBack)
            {
                string op = Request.QueryString["OP"];
                switch(op)
                {
                    case "M":
                        Helper.AddRemoveHidden(false, btnEdit);
                        break;
                    case "C":
                        Helper.AddRemoveHidden(false, btnCreate);
                        break;
                    case "A":
                        Helper.AddRemoveHidden(false, btnCancel);
                        break;
                    default:
                        lberror.Text = "Página sem contexto. Execute a transação na Aplicação Bancária";
                        lberror.Visible = true;
                        break;
                }

                #region arvore de produto de risco

                makeTreeView(dtProdutos, "NELEMC01", "NELEMC02", "GELEM30", trtipologiaProdutosRFTree);

                makeTreeView(dtProdutos, "NELEMC01", "NELEMC02", "GELEM30", Constantes.tipologiaRisco.RA, trtipologiaProdutosRATree);

                makeTreeView(dtProdutos, "NELEMC01", "NELEMC02", "GELEM30", Constantes.tipologiaRisco.RC, trtipologiaProdutosRCTree);

                trtipologiaProdutosRFTree.ShowExpandCollapse = true;
                trtipologiaProdutosRFTree.ShowLines = true;
                trtipologiaProdutosRFTree.CollapseAll();
                trtipologiaProdutosRFTree.NodeWrap = true;

                trtipologiaProdutosRCTree.ShowExpandCollapse = true;
                trtipologiaProdutosRCTree.ShowLines = true;
                trtipologiaProdutosRCTree.CollapseAll();
                trtipologiaProdutosRCTree.NodeWrap = true;

                trtipologiaProdutosRATree.ShowExpandCollapse = true;
                trtipologiaProdutosRATree.ShowLines = true;
                trtipologiaProdutosRATree.CollapseAll();
                trtipologiaProdutosRATree.NodeWrap = true;

                #endregion

                txtProductCode.Focus();
            }


        }

        protected void ddlIndicadorRenovacao_TextChanged(object sender, EventArgs e)
        {
            if (ddlIndicadorRenovacao.SelectedValue == " ")
            {
                txtPrazoRenovacao.Enabled = false;
            }
        }

        protected void makeTreeView(DataTable dtnodesandchilds, string colnodes, string colsecondNode, string descritivo,  string tipologia, TreeView tree)
        {
            string arprd = Helper.getProdutosTipologia(tipologia);

            //TreeView Produtos
            DataView view = dtnodesandchilds.AsDataView();
            DataTable distinctProdutos = view.ToTable(true, colnodes); //select distinc nodes

            var a = distinctProdutos.Select(colnodes + " IN (" + arprd + ")"); //select produtos por tipologia de risco
           
            //Faz os 1s Nodes - Produtos
            foreach (DataRow row in a)
            {
                string stproduto = row[colnodes].ToString();
                TreeNode produto = new TreeNode(stproduto);

                DataRow[] dtSubProdutos = dtnodesandchilds.Select(colnodes + " = '" + stproduto + "'");

                //Faz os 2os Nodes - SubProduto
                TreeNode[] array = new TreeNode[dtSubProdutos.Length];
                for (int i = 0; i < dtSubProdutos.Length; i++)
                {
                    array[i] = new TreeNode(dtSubProdutos[i][colsecondNode].ToString());
                    array[i].Text = dtSubProdutos[i][colsecondNode].ToString() + " - " + dtSubProdutos[i][descritivo].ToString(); //(codigo + descritivo)
                    produto.ChildNodes.Add(array[i]);
                }

                produto.ShowCheckBox = true;
                tree.Nodes.Add(produto); //Adiciona o nó com os child nodes
            }
        }

        protected void makeTreeView(DataTable dtnodesandchilds, string colnodes, string colsecondNode, string descritivo, TreeView tree)
        {

            //TreeView Produtos
            DataView view = dtnodesandchilds.AsDataView();
            DataTable distinctProdutos = view.ToTable(true, colnodes); //select distinc nodes

            //Faz os 1s Nodes - Produtos
            foreach (DataRow row in distinctProdutos.Rows)
            {
                string stproduto = row[colnodes].ToString();
                TreeNode produto = new TreeNode(stproduto);

                DataRow[] dtSubProdutos = dtnodesandchilds.Select(colnodes + " = '" + stproduto + "'");

                //Faz os 2os Nodes - SubProduto
                TreeNode[] array = new TreeNode[dtSubProdutos.Length];
                for (int i = 0; i < dtSubProdutos.Length; i++)
                {
                    array[i] = new TreeNode(dtSubProdutos[i][colsecondNode].ToString());
                    array[i].Text = dtSubProdutos[i][colsecondNode].ToString() + " - " +  dtSubProdutos[i][descritivo].ToString(); //(codigo + descritivo)
                    produto.ChildNodes.Add(array[i]);
                }

                produto.ShowCheckBox = true;
                tree.Nodes.Add(produto); //Adiciona o nó com os child nodes
            }
        }
    }
    
}