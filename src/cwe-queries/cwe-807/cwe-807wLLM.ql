/**
 * @name User-controlled data used in permissions check
 * @description Using user-controlled data in a permissions check may result in inappropriate
 *              permissions being granted.
 * @kind path-problem
 * @problem.severity error
 * @security-severity 7.8
 * @precision high
 * @id java/my-tainted-permissions-check
 * @tags security
 *       external/cwe/cwe-807
 *       external/cwe/cwe-290
 */

import java
import MyTaintedPermissionsCheckQuery
import TaintedPermissionsCheckFlow::PathGraph

from
  TaintedPermissionsCheckFlow::PathNode source, TaintedPermissionsCheckFlow::PathNode sink,
  PermissionsConstruction p
where sink.getNode().asExpr() = p.getInput() and TaintedPermissionsCheckFlow::flowPath(source, sink)
select p, source, sink, "Permissions check depends on a $@.", source.getNode(),
  "user-controlled value"
