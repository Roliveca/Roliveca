using MultilinhasObjects;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI.HtmlControls;

namespace Multilinha
{
    public class Helper
    {

        public static string getProdutosTipologia(string tipologia)
        {
            string arprodutos = "";

            switch (tipologia)
            {
                case Constantes.tipologiaRisco.RF:
                    break;
                case Constantes.tipologiaRisco.RA:
                    arprodutos = "'97'";
                    break;
                case Constantes.tipologiaRisco.RC:
                    arprodutos = "'81', '96'";
                    break;
            };

            return arprodutos;
        }

        public static void AddRemoveHidden(bool addHidden, params System.Web.UI.HtmlControls.HtmlControl[] ctrls)
        {
            AddRemoveCssClass(addHidden, "hidden", ctrls);
        }

        public static void AddRemoveCssClass(bool addRemoveClass, string cssClass, params System.Web.UI.HtmlControls.HtmlControl[] ctrls)
        {
            string className = "class", currCss;

            if (addRemoveClass) //Adiciona Class
                foreach (var ctrl in ctrls)
                {
                    currCss = ctrl.Attributes[className];
                    ctrl.Attributes.Remove(className);
                    if (currCss != null && currCss.Contains(cssClass))
                        ctrl.Attributes.Add(className, currCss);
                    else if (currCss != null)
                        ctrl.Attributes.Add(className, String.Join(" ", currCss, cssClass));
                    else
                        ctrl.Attributes.Add(className, cssClass);
                }
            else //Remove
            {
                foreach (var ctrl in ctrls)
                {
                    currCss = ctrl.Attributes[className];
                    ctrl.Attributes.Remove(className);
                    if (currCss != null)
                        ctrl.Attributes.Add(className, currCss.Replace(cssClass, string.Empty));
                }
            }
        }


        public static void EnableDisableCtrl(bool enabled, params System.Web.UI.Control[] ctrls)
        {
            EnableDisableCtrlEnum(enabled, ctrls);
        }

        public static void EnableDisableCtrlEnum(bool enabled, IEnumerable ctrls)
        {
            System.Web.UI.WebControls.TextBox txt = null;
            System.Web.UI.HtmlControls.HtmlSelect cmb = null;
            System.Web.UI.HtmlControls.HtmlButton btn = null;

            if (!enabled) //Disable
                foreach (var ctrl in ctrls)
                {
                    if (ctrl is System.Web.UI.WebControls.TextBox)
                    {
                        txt = (System.Web.UI.WebControls.TextBox)ctrl;
                        //AddAttributeWeb("readonly", "true", txt);
                        txt.ReadOnly = true;

                    }
                    else if (ctrl is System.Web.UI.HtmlControls.HtmlSelect)
                    {
                        cmb = (System.Web.UI.HtmlControls.HtmlSelect)ctrl;
                        //AddAttribute("disabled", "true", cmb);
                        cmb.Disabled = true;
                    }
                    else if(ctrl is System.Web.UI.HtmlControls.HtmlButton)
                    {
                        btn = (System.Web.UI.HtmlControls.HtmlButton)ctrl;
                        //AddAttribute("disabled", "true", cmb);
                        btn.Disabled = true;
                    }
                }
            else //Enable
                foreach (var ctrl in ctrls)
                {
                    if (ctrl is System.Web.UI.WebControls.TextBox)
                    {
                        txt = (System.Web.UI.WebControls.TextBox)ctrl;
                        txt.ReadOnly = false;
                        txt.Enabled = true;
                    }
                    else if (ctrl is System.Web.UI.HtmlControls.HtmlSelect)
                    {
                        cmb = (System.Web.UI.HtmlControls.HtmlSelect)ctrl;
                        RemoveAttribute("disabled", cmb);
                        cmb.Disabled = false;
                    }
                }
        }

        public static void RemoveAttribute(string attKey, System.Web.UI.HtmlControls.HtmlControl ctrl)
        {
            RemoveAttributeInCol(attKey, ctrl.Attributes);
        }

        private static void RemoveAttributeInCol(string attKey, System.Web.UI.AttributeCollection attCol)
        {
            if (attCol[attKey] != null)
                attCol.Remove(attKey);
        }


    }
}