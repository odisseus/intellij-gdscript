package plugin

import com.intellij.lang.ASTNode
import com.intellij.psi.tree.TokenSet

object ASTNodePrinter {

    fun build(folder: ASTNode): String {
        val indent = 0
        val sb = StringBuilder()
        build(folder, indent, sb)
        return sb.toString()
    }

    private fun build(folder: ASTNode, indent: Int, sb: StringBuilder) {
        sb.append(getIndentString(indent))
        sb.append(folder.psi.toString())
        sb.append("\n")
        for (file in folder.getChildren(TokenSet.ANY))
            if (file.getChildren(TokenSet.ANY).isNotEmpty())
                build(file, indent + 1, sb)
            else
                printFile(file.toString(), indent + 1, sb)
    }

    private fun printFile(name: String, indent: Int, sb: StringBuilder) {
        sb.append(getIndentString(indent))
        sb.append(name)
        sb.append("\n")
    }

    private fun getIndentString(indent: Int) = "  ".repeat(indent)

}
