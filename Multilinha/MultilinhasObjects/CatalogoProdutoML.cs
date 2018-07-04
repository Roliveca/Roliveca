using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MultilinhasObjects
{
    public class CatalogoProdutoML
    {

        public string ProductCode { get; set; }
        public string SubProductCode { get; set; }
        public string SubProductDescription { get; set; }

        public DateTime DataInicioComercializacao { get; set; }

        public DateTime DataFimComercializacao { get; set; }

        public int PrazoMinimo { get; set; }

        public int PrazoMaximo { get; set; }

        public int NumeroMinimoProdutos { get; set; }

        public decimal LimiteMinimoCredito { get; set; }

        public decimal LimiteMaximoCredito { get; set; }

        public string Estado { get; set; }

        public int NDiasIncumprimento { get; set; }

        public string IndRenovacao { get; set; }

        public int PrazoRenovacao { get; set; }

        public List<Produto> produtos { get; set; }

        public class Produto
        {
            public string tipologia { get; set; }
            public string produto { get; set; }
            public string subproduto { get; set; }
            public string descritivo { get; set; }

        }

        public string PeriocidadeCobranca { get; set; }

    }
    
}
