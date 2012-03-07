// TeX macros
MathJax.Hub.Config({
  TeX: {
    Macros: {
      'vec': ['{\\boldsymbol{#1}}', 1],

      // -- differential operators --
      'de':   '\\textrm{d}',
      'ddt':  '\\frac{\\de}{\\de t}',
      'ddtp': '\\frac{\\partial}{\\partial t}',

      // -- Roman letters used in subscripts
      'arm': '\\textrm{a}',
      'brm': '\\textrm{b}',
      'drm': '\\textrm{d}',
      'frm': '\\textrm{f}',
      'lrm': '\\textrm{l}',
      'rrm': '\\textrm{r}',
      'eff': '\\textrm{eff}',

      'Drm': '\\textrm{D}',
      'Crm': '\\textrm{C}',
      'Trm': '\\textrm{T}',

      // -- Some symbol for physical quantities
      'diam':    '\\textrm{d}',
      'eye':     '\\mathbf{I}',
      'grav':    '\\mathbf{g}',
      'Hbf':     '\\mathbf{H}',
      'tke':     '\\kappa',
      'tdr':     '\\varepsilon',
      'stress':  '\\boldsymbol{\\tau}',
      'Rstress': '\\mathbf{R}',
      'Sbf':     '\\mathbf{S}',
      'U':       '\\mathbf{U}',
    },
    Augment: {
      Definitions: {macros: {
        unit: "customUnitFrac",
        unitfrac: "customUnitFrac",
        nicefrac: "customUnitFrac"
      }},
      Parse: {prototype: {
        customUnitFrac: function (name) {
          var n = this.GetBrackets(name),
              num = this.GetArgument(name),
              den = '',
              tex = '';
          if (n == null) {n = ""}
          if (name == '\\unitfrac' || name == '\\nicefrac') {
            den = this.GetArgument(name);
          }
          if (name == '\\unit' || name == '\\unitfrac')
          {
            tex = n + '\\,\\mathrm{'+num+'}';
            if (name == '\\unitfrac')
              tex += '/\\mathrm{'+den+'}';
          } else if (name == '\\nicefrac') {
            tex = num+'/'+den;
          }
          this.string = tex + this.string.slice(this.i); this.i = 0;
        }
      }}
    }
  }
})
