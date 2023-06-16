import 'package:flutter/material.dart';
import 'summary_items.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.0,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return SummaryItem(data);//question number
          },).toList()
        ),
      ),
    );
  }
}

/*
                    //column children ki list [] leta ha but summaryData phly sy hi list ha isiliye thori changing ki ha

          //Sizedbox ki 300 height k andr column overflow horha ha bcz column ka content zyada ha islie zyada height ly rha ha ..isko hal krny k liye column ko singlechildscrolview me wrap krdo to column cotent scrollable ho jaye ga
          Text(data['question']+1); user ko question no show krany k liye jo k kbi 0 ni hota
          always 1 sy start hota ha,isliye 1 plus kia ha.
           Text(((data['question']as int)+1).toString()),text widget me always string value hi ati not int
            tha isliye sari bracket ko end me .tostring krdia ha video num 32
           */
//The argument type 'Iterable<Row>' can't be assigned to the parameter type 'List<Widget>,,,ye error ko khtm krny k liye summaryData.map ko end p .tolist() krna ha

