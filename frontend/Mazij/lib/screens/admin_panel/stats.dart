import 'package:Mazaj/data/models/statistics_model.dart';
import 'package:flutter/material.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class Stats extends StatelessWidget {
  Statistics stats;
  Stats(this.stats, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((MediaQuery.of(context).size.width >= 1000) &&
        (MediaQuery.of(context).size.height >= 500)) {
      return SafeArea(
          child: Container(
              alignment: Alignment.center,
              child: Row(children: [
                const SizedBox(width: 200),
                Center(
                    child: WidgetCircularAnimator(
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF2A2D3E)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                              color: Colors.white), //apply style to all
                          children: [
                            TextSpan(
                                text: "${stats.users}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35)),
                            const TextSpan(text: "\n New Users this month")
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    width: 250,
                    height: 250,
                  ),
                  innerAnimation: Curves.bounceIn,
                  innerColor: Colors.purpleAccent.shade400,
                  outerAnimation: Curves.linear,
                  outerColor: Colors.white,
                )),
                const SizedBox(
                  width: 100,
                ),
                Center(
                    child: WidgetCircularAnimator(
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF2A2D3E)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                              color: Colors.white), //apply style to all
                          children: [
                            TextSpan(
                                text: "${stats.posts}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35)),
                            const TextSpan(text: "\n Posts this month")
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    width: 250,
                    height: 250,
                  ),
                  innerAnimation: Curves.bounceIn,
                  innerColor: Colors.blueAccent.shade700,
                  outerAnimation: Curves.linear,
                  outerColor: Colors.white,
                )),
                const SizedBox(
                  width: 100,
                ),
                Center(
                    child: WidgetCircularAnimator(
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF2A2D3E)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                              color: Colors.white), //apply style to all
                          children: [
                            TextSpan(
                                text: "${stats.total_upvotes}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35)),
                            const TextSpan(text: "\n Total Upvotes")
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    width: 250,
                    height: 250,
                  ),
                  innerAnimation: Curves.bounceIn,
                  innerColor: Colors.cyan,
                  outerAnimation: Curves.linear,
                  outerColor: Colors.white,
                )),
                const SizedBox(
                  width: 100,
                ),
                Center(
                    child: WidgetCircularAnimator(
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF2A2D3E)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                              color: Colors.white), //apply style to all
                          children: [
                            TextSpan(
                                text: "${stats.max_upvotes}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35)),
                            const TextSpan(text: "\n Maximum Upvotes")
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    width: 250,
                    height: 250,
                  ),
                  innerAnimation: Curves.bounceIn,
                  innerColor: Colors.deepPurpleAccent.shade700,
                  outerAnimation: Curves.linear,
                  outerColor: Colors.white,
                )),
              ])));
    }
    return SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: Column(children: [
              const SizedBox(width: 200),
              Center(
                  child: WidgetCircularAnimator(
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF2A2D3E)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            color: Colors.white), //apply style to all
                        children: [
                          TextSpan(
                              text: "${stats.users}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35)),
                          const TextSpan(text: "\n New Users this month")
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  width: 250,
                  height: 250,
                ),
                innerAnimation: Curves.bounceIn,
                innerColor: Colors.purpleAccent.shade400,
                outerAnimation: Curves.linear,
                outerColor: Colors.white,
              )),
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: WidgetCircularAnimator(
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF2A2D3E)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            color: Colors.white), //apply style to all
                        children: [
                          TextSpan(
                              text: "${stats.posts}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35)),
                          const TextSpan(text: "\n Posts this month")
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  width: 250,
                  height: 250,
                ),
                innerAnimation: Curves.bounceIn,
                innerColor: Colors.blueAccent.shade700,
                outerAnimation: Curves.linear,
                outerColor: Colors.white,
              )),
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: WidgetCircularAnimator(
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF2A2D3E)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            color: Colors.white), //apply style to all
                        children: [
                          TextSpan(
                              text: "${stats.total_upvotes}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35)),
                          const TextSpan(text: "\n Total Upvotes")
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  width: 250,
                  height: 250,
                ),
                innerAnimation: Curves.bounceIn,
                innerColor: Colors.cyan,
                outerAnimation: Curves.linear,
                outerColor: Colors.white,
              )),
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: WidgetCircularAnimator(
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF2A2D3E)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            color: Colors.white), //apply style to all
                        children: [
                          TextSpan(
                              text: "${stats.max_upvotes}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35)),
                          const TextSpan(text: "\n Maximum Upvotes")
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  width: 250,
                  height: 250,
                ),
                innerAnimation: Curves.bounceIn,
                innerColor: Colors.deepPurpleAccent.shade700,
                outerAnimation: Curves.linear,
                outerColor: Colors.white,
              )),
            ])));
  }
}
