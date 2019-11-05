package gdscript.completion

import gdscript.BaseTest
import uitlities.openCode
import uitlities.assertContains
import uitlities.assertNotContains
import uitlities.lookups

class PrimaryCompletionContributorTest : BaseTest() {

    fun `test keyword as value`() {
        environment.openCode("x = <caret>")
        environment.completeBasic()
        assertContains(environment.lookups(), "self")
        assertContains(environment.lookups(), "null")
        assertContains(environment.lookups(), "false")
    }

    fun `test function as statement`() {
        environment.openCode("pr<caret>")
        environment.completeBasic()
        assertContains(environment.lookups(), "print")
    }

    fun `test function in var statement`() {
        environment.openCode("var x = si<caret>")
        environment.completeBasic()
        assertContains(environment.lookups(), "sin")
    }

    fun `test function in dictionary`() {
        environment.openCode("dict = {A = 1, B = si<caret>}")
        environment.completeBasic()
        assertContains(environment.lookups(), "sin")
    }

    fun `test Vector2 constructor`() {
        environment.openCode("position = Vec<caret>")
        environment.completeBasic()
        assertContains(environment.lookups(), "Vector2")
    }

    fun `test primitive float constructor`() {
        environment.openCode("x = flo<caret>")
        environment.completeBasic()
        assertContains(environment.lookups(), "float")
    }

    fun `test function is case-sensitive`() {
        environment.openCode("x = Si<caret>()")
        environment.completeBasic()
        assertNotContains(environment.lookups(), "sin")
    }

    fun `test constructor call is case-sensitive`() {
        environment.openCode("position = vec<caret>()")
        environment.completeBasic()
        assertNotContains(environment.lookups(), "Vector2")
    }

    fun `test values are not present after DOT operator`() {
        environment.openCode("vector.fa<caret>")
        environment.completeBasic()
        assertNotContains(environment.lookups(), "false")
    }

    fun `test do not complete inside string`() {
        environment.openCode("""x = "flo<caret>" """)
        environment.completeBasic()
        assertNotContains(environment.lookups(), "float")
    }

    fun `test variable completion in argument default value`() {
        environment.openCode("func f(arg=nul<caret>):")
        environment.completeBasic()
        assertNotContains(environment.lookups(), "null")
    }

    fun `test typing numbers doesn't invokes constants with numbers in names`() {
        environment.openCode("x = 1<caret>")
        environment.completeBasic()
        assertEmpty(environment.lookups())
    }

}
