package plugin.psi

import com.intellij.psi.PsiElement

/** A reference object associated with (referring to) a IdentifierPsiINode
 * underneath a call_expr rule subtree root.
 */
class FunctionRef(element: IdentifierPsiINode) : GDScriptElementRef(element) {

    override fun isDefSubtree(def: PsiElement): Boolean {
        return def is FunctionSubtree
    }

}
