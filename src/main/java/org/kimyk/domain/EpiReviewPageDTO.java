package org.kimyk.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class EpiReviewPageDTO {
	private int epiReviewCnt;
	private List<EpiReviewVO> list;

}
